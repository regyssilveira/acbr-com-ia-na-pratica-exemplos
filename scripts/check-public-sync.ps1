param(
    [Parameter(Mandatory)] [string]$Tag,
    [int]$ExpectedSkills = 22,
    [string]$Repository = 'regyssilveira/acbr-com-ia-na-pratica-exemplos'
)

$ErrorActionPreference = 'Stop'
$remote = "https://github.com/$Repository.git"
$tagRef = (& git ls-remote --tags $remote "refs/tags/$Tag" | Out-String).Trim()
if (-not $tagRef) { throw "Tag pública não encontrada: $Tag" }
$raw = "https://raw.githubusercontent.com/$Repository/$Tag/skills/catalog.json"
$temp = Join-Path ([IO.Path]::GetTempPath()) ("acbr-catalog-" + [guid]::NewGuid().ToString('N') + '.json')
try {
    Invoke-WebRequest -UseBasicParsing -Uri $raw -OutFile $temp
    $catalog = Get-Content -Raw $temp | ConvertFrom-Json
    $count = @($catalog.entries).Count
    if ($count -ne $ExpectedSkills) { throw "Catálogo público contém $count skills; esperado: $ExpectedSkills." }
    Write-Host "OK: $Tag existe no GitHub e contém $count skills no catálogo público."
} finally { if (Test-Path -LiteralPath $temp) { Remove-Item -LiteralPath $temp -Force } }
