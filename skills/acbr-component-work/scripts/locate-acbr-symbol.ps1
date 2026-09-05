param(
    [Parameter(Mandatory = $true)]
    [string]$Checkout,
    [Parameter(Mandatory = $true)]
    [string]$Pattern
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $Checkout).Path
$rg = Get-Command rg -ErrorAction Stop

& $rg.Source --line-number --glob '*.pas' --glob '*.inc' --glob '*.dpk' `
    --glob '!Projetos/ACBrLib/**' --glob '!Projetos/ACBrMonitorPLUS/**' `
    -- $Pattern $root
if ($LASTEXITCODE -gt 1) {
    throw "Falha ao pesquisar o checkout ACBr: $LASTEXITCODE"
}
