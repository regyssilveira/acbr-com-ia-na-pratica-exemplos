param(
    [string]$RadStudioRoot = 'C:\Program Files (x86)\Embarcadero\Studio\37.0'
)

$ErrorActionPreference = 'Stop'
$compiler = Join-Path $RadStudioRoot 'bin\dcc32.exe'
$lab = Join-Path $PSScriptRoot '..\lab\CaixaAgil.Lab.dpr'

if (-not (Test-Path -LiteralPath $compiler)) { throw "Compilador não encontrado: $compiler" }

Push-Location (Split-Path -Parent $lab)
try {
    $labDirectory = (Resolve-Path '.').Path
    $database = [System.IO.Path]::GetFullPath((Join-Path $labDirectory 'output\caixa-agil.sqlite'))
    if (-not $database.StartsWith($labDirectory, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Caminho de evidência fora do laboratório: $database"
    }
    if (Test-Path -LiteralPath $database) {
        Remove-Item -LiteralPath $database -Force
    }
    & $compiler '-B' '-Q' (Split-Path -Leaf $lab)
    if ($LASTEXITCODE -ne 0) { throw "Compilação do laboratório falhou: $LASTEXITCODE" }
    & .\CaixaAgil.Lab.exe
    if ($LASTEXITCODE -ne 0) { throw "Laboratório falhou: $LASTEXITCODE" }
}
finally { Pop-Location }
