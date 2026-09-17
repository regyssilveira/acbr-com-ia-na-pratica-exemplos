param([string]$OutputPath = (Join-Path $PSScriptRoot 'out\certificate-lab.json'))
$ErrorActionPreference = 'Stop'

# Metadados inteiramente fictícios: o laboratório não abre repositórios de certificados.
$cases = @(
    @{ name='válido-em-homologação'; environment='homologacao'; hasPrivateKey=$true; expiresInDays=120; expected='ready' },
    @{ name='sem-chave-privada'; environment='homologacao'; hasPrivateKey=$false; expiresInDays=120; expected='blocked' },
    @{ name='expirado'; environment='homologacao'; hasPrivateKey=$true; expiresInDays=-2; expected='blocked' },
    @{ name='produção-não-autorizada'; environment='producao'; hasPrivateKey=$true; expiresInDays=120; expected='manual-approval' }
)
$results = foreach ($case in $cases) {
    $actual = if (-not $case.hasPrivateKey -or $case.expiresInDays -lt 1) { 'blocked' }
              elseif ($case.environment -eq 'producao') { 'manual-approval' }
              else { 'ready' }
    [pscustomobject]@{ name=$case.name; expected=$case.expected; actual=$actual; passed=($actual -eq $case.expected) }
}
if (@($results | Where-Object { -not $_.passed }).Count) { throw 'Falha no laboratório de certificado.' }
New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent) | Out-Null
$results | ConvertTo-Json | Set-Content -LiteralPath $OutputPath -Encoding utf8
Write-Host 'OK: 4 cenários fictícios de certificado/ambiente validados; nenhum certificado real foi acessado.'
