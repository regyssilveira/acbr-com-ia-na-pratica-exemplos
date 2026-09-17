$ErrorActionPreference = 'Stop'

$root = Split-Path $PSScriptRoot -Parent
$skillsRoot = Join-Path $root 'skills'
$catalogPath = Join-Path $skillsRoot 'catalog.json'
$catalog = Get-Content -Raw -LiteralPath $catalogPath | ConvertFrom-Json
$manifest = Get-Content -Raw -LiteralPath (Join-Path $root 'manifest\examples.json') | ConvertFrom-Json
$validKinds = @('router', 'task', 'family')
$validStates = @('PL', 'IM', 'CP', 'EX', 'RV')
$ids = @($catalog.entries | ForEach-Object { $_.id })
$profiles = Get-Content -Raw -LiteralPath (Join-Path $skillsRoot 'profiles.json') | ConvertFrom-Json

if ($catalog.schemaVersion -ne 1) { throw 'Versão de schema do catálogo não suportada.' }
if ($ids.Count -ne @($ids | Sort-Object -Unique).Count) { throw 'Há IDs duplicados no catálogo de skills.' }

foreach ($entry in $catalog.entries) {
    if ($entry.id -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') { throw "ID inválido no catálogo: $($entry.id)" }
    if ($entry.kind -notin $validKinds) { throw "Tipo inválido em $($entry.id): $($entry.kind)" }
    if ($entry.state -notin $validStates) { throw "Estado inválido em $($entry.id): $($entry.state)" }

    $skillFile = Join-Path $skillsRoot "$($entry.id)\SKILL.md"
    if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) { throw "Skill catalogada sem SKILL.md: $($entry.id)" }

    foreach ($route in @($entry.routes | Where-Object { $_ })) {
        if ($route -notin $ids) { throw "Rota inexistente em $($entry.id): $route" }
    }

    if ($entry.kind -eq 'family') {
        if (@($entry.components).Count -eq 0) { throw "Família sem componentes: $($entry.id)" }
        foreach ($component in $entry.components) {
            $reference = Join-Path $skillsRoot "$($entry.id)\references\$component.md"
            if (-not (Test-Path -LiteralPath $reference -PathType Leaf)) {
                throw "Referência de componente ausente em $($entry.id): $component.md"
            }
        }
    }
}

foreach ($profileName in @('core','dfe','payments','devices','full')) {
    $items = @($profiles.profiles.$profileName)
    if ($items.Count -eq 0) { throw "Perfil vazio ou ausente: $profileName" }
    foreach ($item in $items) {
        if ($item -ne '*' -and $item -ne '@core' -and $item -notin $ids) { throw "Skill inexistente no perfil ${profileName}: $item" }
    }
}

$directories = @(Get-ChildItem -LiteralPath $skillsRoot -Directory | ForEach-Object { $_.Name })
$uncatalogued = @($directories | Where-Object { $_ -notin $ids })
if ($uncatalogued.Count -gt 0) { throw "Skills fora do catálogo: $($uncatalogued -join ', ')" }

$manifestIds = @($manifest.skills | ForEach-Object { $_.id })
$missingInManifest = @($ids | Where-Object { $_ -notin $manifestIds })
$missingInCatalog = @($manifestIds | Where-Object { $_ -notin $ids })
if ($missingInManifest.Count -gt 0) { throw "Skills ausentes no manifesto: $($missingInManifest -join ', ')" }
if ($missingInCatalog.Count -gt 0) { throw "Skills ausentes no catálogo: $($missingInCatalog -join ', ')" }
foreach ($entry in $catalog.entries) {
    $manifestEntry = $manifest.skills | Where-Object id -eq $entry.id
    if ($manifestEntry.state -ne $entry.state) { throw "Estado divergente para $($entry.id): catálogo=$($entry.state), manifesto=$($manifestEntry.state)" }
    foreach ($evidence in @($manifestEntry.evidence)) {
        if (-not (Test-Path -LiteralPath (Join-Path $root $evidence) -PathType Leaf)) { throw "Evidência ausente para $($entry.id): $evidence" }
    }
}

Write-Host "OK: catálogo consistente com $($ids.Count) skills."
