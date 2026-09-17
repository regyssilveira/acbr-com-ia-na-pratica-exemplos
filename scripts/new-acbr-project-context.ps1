param(
    [Parameter(Mandatory)] [string]$ProjectFile,
    [Parameter(Mandatory)] [string]$AcbrRoot,
    [string]$OutputDirectory = '.\.acbr-ai',
    [switch]$Apply
)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$project = (Resolve-Path -LiteralPath $ProjectFile).Path
$acbr = (Resolve-Path -LiteralPath $AcbrRoot).Path
$target = [IO.Path]::GetFullPath($OutputDirectory)
Write-Host "Projeto: $project"
Write-Host "ACBr: $acbr"
Write-Host "Destino: $target"
if (Test-Path -LiteralPath $target) { throw 'O destino já existe; escolha uma pasta nova.' }
if (-not $Apply) { Write-Host 'Simulação concluída. Use -Apply para gerar o kit.'; return }
New-Item -ItemType Directory -Path $target | Out-Null
Copy-Item -LiteralPath (Join-Path $root 'templates\project-context\AGENTS.md') -Destination (Join-Path $target 'AGENTS.md')
& (Join-Path $PSScriptRoot 'acbr-doctor.ps1') -ProjectFile $project -AcbrRoot $acbr -OutputPath (Join-Path $target 'baseline.json')
[ordered]@{ schemaVersion=1; projectFile=$project; acbrRoot=$acbr; generatedAt=(Get-Date).ToString('o'); reviewRequired=$true } |
    ConvertTo-Json | Set-Content -LiteralPath (Join-Path $target 'context.json') -Encoding utf8
Write-Host 'OK: kit criado. Revise os campos [PREENCHER] antes de adotá-lo.'
