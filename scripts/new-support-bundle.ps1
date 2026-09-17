param(
    [Parameter(Mandatory)] [string]$OutputDirectory,
    [string]$ProjectFile,
    [string]$AcbrRoot,
    [string[]]$LogPath = @(),
    [switch]$Zip
)

$ErrorActionPreference = 'Stop'
if (Test-Path -LiteralPath $OutputDirectory) { throw 'A pasta de saída já existe; escolha uma pasta nova.' }
New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
& (Join-Path $PSScriptRoot 'acbr-doctor.ps1') -ProjectFile $ProjectFile -AcbrRoot $AcbrRoot -OutputPath (Join-Path $OutputDirectory 'diagnostico.json')

$logDir = Join-Path $OutputDirectory 'logs-sanitizados'
foreach ($path in $LogPath) {
    New-Item -ItemType Directory -Force -Path $logDir | Out-Null
    $target = Join-Path $logDir ([IO.Path]::GetFileName($path))
    & (Join-Path $PSScriptRoot 'sanitize-acbr-log.ps1') -InputPath $path -OutputPath $target
}

@'
# Pedido de suporte

## O que eu esperava

## O que aconteceu

## Passos mínimos para reproduzir

## Alteração mais recente

## Evidências anexadas

Revise todos os arquivos antes de compartilhar. A sanitização automática não substitui a inspeção humana.
'@ | Set-Content -LiteralPath (Join-Path $OutputDirectory 'pedido-de-suporte.md') -Encoding utf8

if ($Zip) {
    $zipPath = "$OutputDirectory.zip"
    Compress-Archive -LiteralPath $OutputDirectory -DestinationPath $zipPath
    Write-Host "OK: pacote criado em $zipPath. Revise antes de compartilhar."
} else { Write-Host "OK: pacote criado em $OutputDirectory. Revise antes de compartilhar." }
