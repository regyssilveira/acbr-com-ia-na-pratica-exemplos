param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.agents\skills'),
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

function Get-PackageSignature([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) { return '' }
    $base = [IO.Path]::GetFullPath($Path).TrimEnd('\')
    return (@(Get-ChildItem -LiteralPath $Path -File -Recurse -Force | Sort-Object FullName | ForEach-Object {
        $_.FullName.Substring($base.Length) + ':' + (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash
    }) -join "`n")
}
$Destination = [IO.Path]::GetFullPath($Destination).TrimEnd('\')
$backupRoot = "$Destination.backups"
Write-Host "Destino: $Destination"
foreach ($item in $selected) {
    $target = Join-Path $Destination $item.Name
    $action = if (-not (Test-Path -LiteralPath $target)) { 'instalar' }
              elseif ((Get-PackageSignature $item.FullName) -eq (Get-PackageSignature $target)) { 'atual' }
              else { 'atualizar (backup antes)' }
    Write-Host ("- {0}: {1}" -f $item.Name, $action)
}
if ($CheckUpdates) { Write-Host 'Consulta concluída; nenhuma cópia foi alterada.'; return }
if (-not $Apply) { Write-Host 'Simulação concluída. Execute novamente com -Apply para copiar.'; return }

New-Item -ItemType Directory -Force -Path $Destination | Out-Null
foreach ($item in $selected) {
    $target = Join-Path $Destination $item.Name
    if ((Get-PackageSignature $item.FullName) -eq (Get-PackageSignature $target)) { continue }
    if ([IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($target)) -ne $Destination) { throw 'Destino fora da pasta de skills.' }
    foreach ($path in @($Destination, $target, $backupRoot)) {
        if ((Test-Path -LiteralPath $path) -and ((Get-Item -LiteralPath $path).Attributes -band [IO.FileAttributes]::ReparsePoint)) { throw "Destino redirecionado não permitido: $path" }
    }
    New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
    $id = [guid]::NewGuid().ToString('N')
    $stage = Join-Path $backupRoot "stage-$($item.Name)-$id"
    $backup = Join-Path $backupRoot "$($item.Name)-$id"
    Copy-Item -LiteralPath $item.FullName -Destination $stage -Recurse
    if (Test-Path -LiteralPath $target) {
        Move-Item -LiteralPath $target -Destination $backup
    }
    try { Move-Item -LiteralPath $stage -Destination $target }
    catch {
        if ((Test-Path -LiteralPath $backup) -and -not (Test-Path -LiteralPath $target)) { Move-Item -LiteralPath $backup -Destination $target }
        throw
    }
}
Write-Host ("OK: {0} skill(s) instalada(s)/atualizada(s)." -f $selected.Count)
