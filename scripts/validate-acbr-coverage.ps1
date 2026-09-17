param(
    [string]$AcbrRoot = 'D:\Delphi\ACBr'
)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path $PSScriptRoot -Parent
$skillsRoot = Join-Path $repositoryRoot 'skills'
$catalog = Get-Content -Raw -LiteralPath (Join-Path $skillsRoot 'catalog.json') | ConvertFrom-Json
$index = Get-Content -Raw -LiteralPath (Join-Path $skillsRoot 'component-index.json') | ConvertFrom-Json

if (-not (Test-Path -LiteralPath $AcbrRoot -PathType Container)) { throw "Checkout ACBr não encontrado: $AcbrRoot" }

$expected = @($catalog.entries | Where-Object kind -eq 'family' | ForEach-Object {
    $family = $_.id
    $_.components | ForEach-Object { "$family/$_" }
})
$indexed = @($index.components | ForEach-Object { "$($_.family)/$($_.id)" })
$missing = @($expected | Where-Object { $_ -notin $indexed })
$extra = @($indexed | Where-Object { $_ -notin $expected })
if ($missing.Count -gt 0) { throw "Componentes sem índice: $($missing -join ', ')" }
if ($extra.Count -gt 0) { throw "Componentes indexados fora do catálogo: $($extra -join ', ')" }

foreach ($component in $index.components) {
    $sourcePaths = @($component.sourceRoots | ForEach-Object { Join-Path $AcbrRoot $_ } | Where-Object { Test-Path -LiteralPath $_ -PathType Container })
    $demoPaths = @($component.demoRoots | ForEach-Object { Join-Path $AcbrRoot $_ } | Where-Object { Test-Path -LiteralPath $_ -PathType Container })
    if ($sourcePaths.Count -eq 0) { throw "Fonte não localizado para $($component.id): $($component.sourceRoots -join ', ')" }
    if ($demoPaths.Count -eq 0) { throw "Demo não localizada para $($component.id): $($component.demoRoots -join ', ')" }

    & rg -l -m 1 --glob '*.pas' --glob '*.pp' -- $component.searchTerm $sourcePaths *> $null
    if ($LASTEXITCODE -ne 0) { throw "Símbolo de entrada não localizado para $($component.id): $($component.searchTerm)" }
}

Write-Host "OK: $($index.components.Count) referências conferidas em fontes e demos do checkout ACBr."
