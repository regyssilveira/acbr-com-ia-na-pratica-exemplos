param([Parameter(Mandatory=$true)][string]$InputDirectory)
$ErrorActionPreference = 'Stop'
$reportPath = Join-Path ([IO.Path]::GetTempPath()) ("acbr-exercise-" + [guid]::NewGuid().ToString('N') + '.json')
try {
    & (Join-Path $PSScriptRoot 'check-pas-dfm.ps1') -PasFile (Join-Path $InputDirectory 'BrokenForm.pas') -DfmFile (Join-Path $InputDirectory 'BrokenForm.dfm') -OutputPath $reportPath
    $report = Get-Content -LiteralPath $reportPath -Raw | ConvertFrom-Json
    if (@($report.missingEventHandlers).Count -or @($report.missingComponentFields).Count) { throw 'Correção incompleta: confira o evento e o campo do componente.' }
    Write-Host 'OK: 0 eventos ausentes; 0 campos ausentes. Conferência textual, não compilação.'
}
finally { if (Test-Path -LiteralPath $reportPath) { Remove-Item -LiteralPath $reportPath } }
