param(
    [Parameter(Mandatory = $true)][string]$ProjectFile,
    [string[]]$AdditionalPath = @(),
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$projectFull = (Resolve-Path -LiteralPath $ProjectFile).Path
$projectDirectory = Split-Path $projectFull -Parent
[xml]$xml = Get-Content -Raw -LiteralPath $projectFull
$rawValues = @($xml.Project.PropertyGroup.DCC_UnitSearchPath, $xml.Project.PropertyGroup.DCC_DcuOutput) + $AdditionalPath
$segments = @($rawValues | Where-Object { $_ } | ForEach-Object { $_ -split ';' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })

$resolved = [System.Collections.Generic.List[string]]::new()
$unresolved = [System.Collections.Generic.List[string]]::new()
foreach ($segment in $segments) {
    if ($segment -match '\$\(|%[^%]+%|\*') { $unresolved.Add($segment); continue }
    $candidate = if ([IO.Path]::IsPathRooted($segment)) { $segment } else { Join-Path $projectDirectory $segment }
    $candidate = [IO.Path]::GetFullPath($candidate)
    if (Test-Path -LiteralPath $candidate -PathType Container) { $resolved.Add($candidate) } else { $unresolved.Add($segment) }
}

$duplicatePaths = @($resolved | Group-Object { $_.TrimEnd('\').ToLowerInvariant() } | Where-Object Count -gt 1 | ForEach-Object { $_.Group[0] })
$dcus = foreach ($path in ($resolved | Sort-Object -Unique)) {
    Get-ChildItem -LiteralPath $path -Filter '*.dcu' -File -ErrorAction SilentlyContinue | ForEach-Object {
        [pscustomobject]@{ Name=$_.Name.ToLowerInvariant(); Path=$_.FullName }
    }
}
$duplicateDcus = @($dcus | Group-Object Name | Where-Object Count -gt 1 | ForEach-Object {
    [ordered]@{ name=$_.Name; locations=@($_.Group.Path) }
})
$acbrRoots = @($resolved | Where-Object { $_ -match '(?i)[\\/]ACBr([\\/]|$)' } | ForEach-Object {
    if ($_ -match '(?i)^(.*?[\\/]ACBr)(?:[\\/]|$)') { $Matches[1] }
} | Sort-Object -Unique)

$report = [ordered]@{
    project = $projectFull
    resolvedPaths = @($resolved | Sort-Object -Unique)
    unresolvedOrMacroPaths = @($unresolved | Sort-Object -Unique)
    duplicatePaths = $duplicatePaths
    duplicateDcus = $duplicateDcus
    acbrRoots = $acbrRoots
    warning = 'Relatório somente leitura; macros não são expandidas e devem ser conferidas no ambiente do Delphi.'
}
$json = $report | ConvertTo-Json -Depth 6
if ($OutputPath) {
    $outputFull = [IO.Path]::GetFullPath($OutputPath)
    if (Test-Path -LiteralPath $outputFull) { throw "A saída já existe: $outputFull" }
    $directory = Split-Path $outputFull -Parent
    if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory | Out-Null }
    [IO.File]::WriteAllText($outputFull, $json, [Text.UTF8Encoding]::new($false))
    Write-Host "OK: inventário gravado em $outputFull"
}
else { $json }
