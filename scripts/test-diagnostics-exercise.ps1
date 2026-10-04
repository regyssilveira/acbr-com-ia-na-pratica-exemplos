param([Parameter(Mandatory=$true)][string]$InputDirectory)
$ErrorActionPreference = 'Stop'
$reportPath = Join-Path ([IO.Path]::GetTempPath()) ("acbr-exercise-" + [guid]::NewGuid().ToString('N') + '.json')
try {
    & (Join-Path $PSScriptRoot 'check-pas-dfm.ps1') -PasFile (Join-Path $InputDirectory 'BrokenForm.pas') -DfmFile (Join-Path $InputDirectory 'BrokenForm.dfm') -OutputPath $reportPath
    $report = Get-Content -LiteralPath $reportPath -Raw | ConvertFrom-Json
    if ($report.rootName -ne 'BrokenForm' -or $report.rootClass -ne 'TBrokenForm') { throw 'Exercise root must be preserved.' }
    foreach ($expected in @(@('Button1','TButton'), @('ACBrNFe1','TACBrNFe'))) {
        if (@($report.objects | Where-Object { $_.name -eq $expected[0] -and $_.class -eq $expected[1] }).Count -ne 1) { throw "Exercise component must be preserved: $($expected[0])" }
    }
    $dfmText = Get-Content -LiteralPath (Join-Path $InputDirectory 'BrokenForm.dfm') -Raw
    if ($dfmText -notmatch '(?ms)^\s*object\s+Button1\s*:\s*TButton\s*\r?\n(?:(?!^\s*(?:object|inherited|end)\b).)*?^\s*OnClick\s*=\s*MissingClick\s*$') { throw 'Button1.OnClick must remain bound to MissingClick.' }
    if (@($report.missingEventHandlers).Count -or @($report.missingComponentFields).Count) { throw 'Correção incompleta: confira o evento e o campo do componente.' }
    Write-Host 'OK: 0 eventos ausentes; 0 campos ausentes. Conferência textual, não compilação.'
}
finally { if (Test-Path -LiteralPath $reportPath) { Remove-Item -LiteralPath $reportPath } }
