param(
    [string]$ProjectFile,
    [string]$AcbrRoot,
    [string]$OutputPath = (Join-Path (Get-Location) 'acbr-doctor.json')
)

$ErrorActionPreference = 'Stop'
$report = [ordered]@{
    schemaVersion = 2
    toolVersion = 'pilot-v0.8.0'
    generatedAt = (Get-Date).ToString('o')
    validUntil = (Get-Date).AddDays(30).ToString('o')
    regenerateWhen = @('trocar revisão ACBr','trocar Delphi ou plataforma','alterar paths/packages','mudar projeto ou configuração')
    readOnly = $true
    machine = [Environment]::MachineName
    powershell = $PSVersionTable.PSVersion.ToString()
    project = $null
    acbr = $null
    findings = @()
}

if ($ProjectFile) {
    $resolvedProject = (Resolve-Path -LiteralPath $ProjectFile).Path
    $tempPaths = Join-Path ([IO.Path]::GetTempPath()) ("acbr-doctor-paths-" + [guid]::NewGuid().ToString('N') + '.json')
    & (Join-Path $PSScriptRoot 'inspect-delphi-paths.ps1') -ProjectFile $resolvedProject -OutputPath $tempPaths
    $report.project = Get-Content -Raw $tempPaths | ConvertFrom-Json
    Remove-Item -LiteralPath $tempPaths -Force
    if (@($report.project.duplicateDcus).Count) { $report.findings += 'Há DCUs de mesmo nome em mais de um path.' }
    if (@($report.project.unresolvedOrMacroPaths).Count) { $report.findings += 'Há macros ou paths que precisam ser conferidos no RAD Studio.' }
}

if ($AcbrRoot) {
    $resolvedAcbr = (Resolve-Path -LiteralPath $AcbrRoot).Path
    $svnRevision = $null
    $svn = Get-Command svnversion -ErrorAction SilentlyContinue
    if ($svn) { $svnRevision = (& $svn.Source $resolvedAcbr 2>$null | Out-String).Trim() }
    $report.acbr = [ordered]@{
        root = $resolvedAcbr
        svnRevision = $svnRevision
        sourceFiles = @(Get-ChildItem -LiteralPath (Join-Path $resolvedAcbr 'Fontes') -Filter '*.pas' -Recurse -ErrorAction SilentlyContinue).Count
    }
}

$parent = Split-Path $OutputPath -Parent
if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
$report | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $OutputPath -Encoding utf8
Write-Host "OK: diagnóstico somente leitura salvo em $OutputPath"
