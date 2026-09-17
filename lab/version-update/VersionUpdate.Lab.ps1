param([string]$OutputPath = (Join-Path $PSScriptRoot 'out\version-update-lab.json'))
$ErrorActionPreference = 'Stop'

$old = @{ TACBrNFe=$true; ModeloDF=$true; LegacyFlag=$true }
$new = @{ TACBrNFe=$true; ModeloDF=$true; NewFlag=$true }
$patterns = @('TACBrNFe','ModeloDF','LegacyFlag','NewFlag')
$result = foreach ($name in $patterns) {
    $status = if ($old.ContainsKey($name) -and $new.ContainsKey($name)) { 'unchanged' }
              elseif ($old.ContainsKey($name)) { 'removed' } else { 'added' }
    [pscustomobject]@{ symbol=$name; status=$status }
}
if (($result | Where-Object symbol -eq 'LegacyFlag').status -ne 'removed') { throw 'Remoção não detectada.' }
if (($result | Where-Object symbol -eq 'NewFlag').status -ne 'added') { throw 'Adição não detectada.' }
New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent) | Out-Null
$result | ConvertTo-Json | Set-Content -LiteralPath $OutputPath -Encoding utf8
Write-Host 'OK: migração sintética identificou símbolos mantidos, removidos e adicionados.'
