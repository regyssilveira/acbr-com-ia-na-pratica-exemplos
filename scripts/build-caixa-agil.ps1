param(
    [ValidateSet('Win32')]
    [string]$Platform = 'Win32',
    [string]$RadStudioRoot = 'C:\Program Files (x86)\Embarcadero\Studio\37.0',
    [string]$AcbrLibrary = 'D:\Delphi\ACBr\Lib\Delphi\LibD37\Win32'
)

$ErrorActionPreference = 'Stop'

$compiler = Join-Path $RadStudioRoot 'bin\dcc32.exe'
$project = Join-Path $PSScriptRoot '..\project\CaixaAgil\CaixaAgil.dpr'

if (-not (Test-Path -LiteralPath $compiler)) {
    throw "Compilador não encontrado: $compiler"
}

if (-not (Test-Path -LiteralPath (Join-Path $AcbrLibrary 'ACBrNFe.dcu'))) {
    throw "Biblioteca ACBr Win32 não encontrada: $AcbrLibrary"
}

Push-Location (Split-Path -Parent $project)
try {
    & $compiler '-B' '-Q' "-U$AcbrLibrary" (Split-Path -Leaf $project)
    if ($LASTEXITCODE -ne 0) {
        throw "Compilação falhou com código $LASTEXITCODE"
    }
}
finally {
    Pop-Location
}
