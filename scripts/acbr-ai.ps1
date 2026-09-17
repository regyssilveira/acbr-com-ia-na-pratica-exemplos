param(
    [Parameter(Mandatory,Position=0)] [ValidateSet('start','diagnose','update','support','ready')] [string]$Command,
    [string]$ProjectFile,
    [string]$AcbrRoot,
    [string]$Problem = 'não informado',
    [ValidateSet('dfe','payments','devices','text','communication','none')] [string]$Family='none',
    [string]$OutputDirectory = '.\acbr-ai-output'
)
$ErrorActionPreference='Stop'
if ($Command -eq 'start') { & (Join-Path $PSScriptRoot 'start-guided-workflow.ps1') -Workflow integration -Family $Family; return }
if (-not $ProjectFile) { throw '-ProjectFile é obrigatório para este comando.' }
if (Test-Path -LiteralPath $OutputDirectory) { throw 'A pasta de saída já existe; escolha uma pasta nova para preservar a coleta anterior.' }
New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
$diagnosis = Join-Path $OutputDirectory 'diagnostico.json'
& (Join-Path $PSScriptRoot 'acbr-doctor.ps1') -ProjectFile $ProjectFile -AcbrRoot $AcbrRoot -OutputPath $diagnosis
switch ($Command) {
    diagnose {
        & (Join-Path $PSScriptRoot 'new-diagnostic-prompt.ps1') -DiagnosisPath $diagnosis -Problem $Problem -OutputPath (Join-Path $OutputDirectory 'prompt.md')
        & (Join-Path $PSScriptRoot 'export-doctor-html.ps1') -DiagnosisPath $diagnosis -OutputPath (Join-Path $OutputDirectory 'relatorio.html')
    }
    ready { & (Join-Path $PSScriptRoot 'test-acbr-readiness.ps1') -DiagnosisPath $diagnosis -Scenario $(if($Family -eq 'none'){'dfe'}else{$Family}) -OutputPath (Join-Path $OutputDirectory 'prontidao.json') }
    update { & (Join-Path $PSScriptRoot 'start-guided-workflow.ps1') -Workflow update -Family $Family }
    support { & (Join-Path $PSScriptRoot 'start-guided-workflow.ps1') -Workflow support -Family $Family }
}
Write-Host "OK: artefatos locais em $OutputDirectory"
