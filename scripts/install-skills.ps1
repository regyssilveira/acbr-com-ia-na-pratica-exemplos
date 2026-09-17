param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.codex\skills'),
    [string[]]$Skill = @('*'),
    [ValidateSet('core','dfe','payments','devices','full')] [string]$Profile,
    [switch]$CheckUpdates,
    [switch]$Apply
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$sourceRoot = Join-Path $root 'skills'
$available = @(Get-ChildItem -LiteralPath $sourceRoot -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') })
if ($Profile) {
    $profiles = Get-Content -Raw (Join-Path $sourceRoot 'profiles.json') | ConvertFrom-Json
    $profileItems = @($profiles.profiles.$Profile)
    if ($profileItems -contains '*') { $Skill = @('*') }
    else {
        $expanded = @()
        foreach ($item in $profileItems) {
            if ($item -eq '@core') { $expanded += @($profiles.profiles.core) } else { $expanded += $item }
        }
        $Skill = @($expanded | Sort-Object -Unique)
    }
}
$selected = @($available | Where-Object {
    $name = $_.Name
    @($Skill | Where-Object { $name -like $_ }).Count -gt 0
})
if ($selected.Count -eq 0) { throw 'Nenhuma skill corresponde ao filtro informado.' }

Write-Host "Destino: $Destination"
foreach ($item in $selected) {
    $target = Join-Path $Destination $item.Name
    $action = if (-not (Test-Path -LiteralPath $target)) { 'instalar' }
              elseif ((Get-FileHash (Join-Path $item.FullName 'SKILL.md')).Hash -eq (Get-FileHash (Join-Path $target 'SKILL.md')).Hash) { 'atual' }
              else { 'atualizar (backup antes)' }
    Write-Host ("- {0}: {1}" -f $item.Name, $action)
}
if ($CheckUpdates) { Write-Host 'Consulta concluída; nenhuma cópia foi alterada.'; return }
if (-not $Apply) { Write-Host 'Simulação concluída. Execute novamente com -Apply para copiar.'; return }

New-Item -ItemType Directory -Force -Path $Destination | Out-Null
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
foreach ($item in $selected) {
    $target = Join-Path $Destination $item.Name
    if (Test-Path -LiteralPath $target) {
        $backup = "$target.backup-$stamp"
        Copy-Item -LiteralPath $target -Destination $backup -Recurse
    }
    Copy-Item -LiteralPath $item.FullName -Destination $target -Recurse -Force
}
Write-Host ("OK: {0} skill(s) instalada(s)/atualizada(s)." -f $selected.Count)
