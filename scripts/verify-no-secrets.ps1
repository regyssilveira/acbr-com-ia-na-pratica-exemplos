$ErrorActionPreference = 'Stop'
$repository = Resolve-Path (Join-Path $PSScriptRoot '..')
$forbiddenExtensions = @('.pfx', '.p12', '.pem', '.key', '.cer', '.crt', '.xml', '.sqlite', '.db')
$tracked = git -C $repository ls-files

$badFiles = $tracked | Where-Object {
    $extension = [System.IO.Path]::GetExtension($_).ToLowerInvariant()
    $forbiddenExtensions -contains $extension
}
if ($badFiles) { throw "Arquivo sensível rastreado: $($badFiles -join ', ')" }

$findings = @()
foreach ($relativePath in $tracked) {
    if ($relativePath -eq 'scripts/verify-no-secrets.ps1') { continue }
    $fullPath = Join-Path $repository $relativePath
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) { continue }
    $matches = Select-String -LiteralPath $fullPath -Pattern '(?i)(password|senha)\s*=\s*[^\s;]+' -ErrorAction SilentlyContinue
    $realMatches = $matches | Where-Object {
        ($_.Line -notmatch 'nao_expor') -and
        ($_.Line -notmatch "ContainsText\(Result, 'password='")
    }
    if ($realMatches) { $findings += $relativePath }
}
if ($findings) {
    $uniqueFindings = ($findings | Sort-Object -Unique) -join ', '
    throw "Possível segredo encontrado: $uniqueFindings"
}

Write-Host "OK: nenhum certificado, XML, banco ou senha preenchida está rastreado."
