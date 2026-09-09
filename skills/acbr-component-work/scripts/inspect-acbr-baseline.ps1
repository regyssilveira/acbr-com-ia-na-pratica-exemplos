param(
    [Parameter(Mandatory = $true)]
    [string]$Checkout,
    [string]$ProjectPath
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $Checkout).Path

$result = [ordered]@{
    Checkout = $root
    VersionControl = 'não identificado'
    Revision = 'não verificada'
    ProjectPath = $null
    ProjectFiles = @()
    AcbrReferences = @()
}

if (Test-Path -LiteralPath (Join-Path $root '.svn')) {
    $svn = Get-Command svn -ErrorAction SilentlyContinue
    $result.VersionControl = 'svn'
    if ($svn) {
        $revisionLine = & $svn.Source info --show-item revision $root 2>$null
        if ($LASTEXITCODE -eq 0 -and $revisionLine) {
            $result.Revision = [string]$revisionLine
        }
    }
} elseif (Test-Path -LiteralPath (Join-Path $root '.git')) {
    $git = Get-Command git -ErrorAction SilentlyContinue
    $result.VersionControl = 'git'
    if ($git) {
        $revisionLine = & $git.Source -C $root rev-parse HEAD 2>$null
        if ($LASTEXITCODE -eq 0 -and $revisionLine) {
            $result.Revision = [string]$revisionLine
        }
    }
}

if ($ProjectPath) {
    $projectRoot = (Resolve-Path -LiteralPath $ProjectPath).Path
    $result.ProjectPath = $projectRoot
    $result.ProjectFiles = @(
        Get-ChildItem -LiteralPath $projectRoot -Recurse -File -Include *.dpr,*.dproj |
            Select-Object -ExpandProperty FullName
    )
    $rg = Get-Command rg -ErrorAction SilentlyContinue
    if ($rg) {
        $result.AcbrReferences = @(
            & $rg.Source --files-with-matches --glob '*.pas' --glob '*.dfm' --glob '*.dpr' --glob '*.dproj' -- 'TACBr|ACBr' $projectRoot
        )
    }
}

[pscustomobject]$result | ConvertTo-Json -Depth 4
