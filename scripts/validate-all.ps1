param(
    [string]$RadStudioRoot = 'C:\Program Files (x86)\Embarcadero\Studio\37.0',
    [string]$AcbrLibrary = 'D:\Delphi\ACBr\Lib\Delphi\LibD37\Win32'
)

$ErrorActionPreference = 'Stop'

$compiler = Join-Path $RadStudioRoot 'bin\dcc32.exe'
$acbrDcu = Join-Path $AcbrLibrary 'ACBrNFe.dcu'
$dunitxDcu = Join-Path $RadStudioRoot 'lib\win32\release\DUnitX.TestFramework.dcu'
foreach ($required in @($compiler, $acbrDcu, $dunitxDcu)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
        throw "Pré-voo: arquivo não encontrado: $required. Confira os parâmetros -RadStudioRoot e -AcbrLibrary; veja docs/primeiros-passos.md."
    }
}

Write-Host "Pré-voo OK: Delphi=$compiler; ACBr=$acbrDcu; DUnitX=$dunitxDcu"

& (Join-Path $PSScriptRoot 'build-caixa-agil.ps1') -RadStudioRoot $RadStudioRoot -AcbrLibrary $AcbrLibrary
& (Join-Path $PSScriptRoot 'test-caixa-agil.ps1') -RadStudioRoot $RadStudioRoot -AcbrLibrary $AcbrLibrary
& (Join-Path $PSScriptRoot 'run-local-lab.ps1') -RadStudioRoot $RadStudioRoot
& (Join-Path $PSScriptRoot 'run-payments-lab.ps1')
& (Join-Path $PSScriptRoot 'run-text-lab.ps1')
& (Join-Path $PSScriptRoot 'run-certificate-lab.ps1')
& (Join-Path $PSScriptRoot 'run-version-update-lab.ps1')
& (Join-Path $PSScriptRoot 'test-skill-tools.ps1')
& (Join-Path $PSScriptRoot 'verify-no-secrets.ps1')
& (Join-Path $PSScriptRoot 'validate-skills.ps1')
& (Join-Path $PSScriptRoot 'validate-skill-catalog.ps1')
& (Join-Path $PSScriptRoot 'validate-behavioral-suite.ps1')
& (Join-Path $PSScriptRoot 'check-text-encoding.ps1')
$acbrRoot = Split-Path (Split-Path (Split-Path (Split-Path $AcbrLibrary -Parent) -Parent) -Parent) -Parent
& (Join-Path $PSScriptRoot 'validate-acbr-coverage.ps1') -AcbrRoot $acbrRoot

Write-Host 'OK: build, testes, laboratórios, ferramentas, segurança, skills, catálogo, codificação e cobertura ACBr concluídos.'
