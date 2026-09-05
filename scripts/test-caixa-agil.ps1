param(
    [string]$RadStudioRoot = 'C:\Program Files (x86)\Embarcadero\Studio\37.0'
)

$ErrorActionPreference = 'Stop'
$compiler = Join-Path $RadStudioRoot 'bin\dcc32.exe'
$dunitx = Join-Path $RadStudioRoot 'lib\win32\release'
$tests = Join-Path $PSScriptRoot '..\tests\CaixaAgil.Tests.dpr'

if (-not (Test-Path -LiteralPath $compiler)) { throw "Compilador não encontrado: $compiler" }
if (-not (Test-Path -LiteralPath (Join-Path $dunitx 'DUnitX.TestFramework.dcu'))) { throw "DUnitX não encontrado: $dunitx" }

Push-Location (Split-Path -Parent $tests)
try {
    & $compiler '-B' '-Q' "-U$dunitx" (Split-Path -Leaf $tests)
    if ($LASTEXITCODE -ne 0) { throw "Compilação dos testes falhou: $LASTEXITCODE" }
    & .\CaixaAgil.Tests.exe
    if ($LASTEXITCODE -ne 0) { throw "Testes falharam: $LASTEXITCODE" }
}
finally { Pop-Location }
