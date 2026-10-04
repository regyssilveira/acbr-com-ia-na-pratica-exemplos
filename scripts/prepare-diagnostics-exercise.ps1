param([Parameter(Mandatory=$true)][string]$OutputDirectory)
$ErrorActionPreference = 'Stop'
$destination = [IO.Path]::GetFullPath($OutputDirectory)
if (Test-Path -LiteralPath $destination) { throw 'Use uma pasta nova; o exercício não sobrescreve arquivos.' }
New-Item -ItemType Directory -Path $destination | Out-Null
foreach ($name in @('BrokenForm.pas','BrokenForm.dfm')) {
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot "../lab/diagnostics/$name") -Destination (Join-Path $destination $name)
}
Write-Host "Cópias para correção: $destination. As fixtures originais foram preservadas."
