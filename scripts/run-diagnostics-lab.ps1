$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$lab=Join-Path $root 'lab\diagnostics'
$temp=Join-Path ([IO.Path]::GetTempPath()) ('acbr-diagnostics-'+[guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temp | Out-Null
try {
    & (Join-Path $PSScriptRoot 'check-pas-dfm.ps1') -PasFile (Join-Path $lab 'BrokenForm.pas') -DfmFile (Join-Path $lab 'BrokenForm.dfm') -OutputPath (Join-Path $temp 'pas-dfm.json')
    $pair=Get-Content -Raw (Join-Path $temp 'pas-dfm.json') | ConvertFrom-Json
    if (@($pair.missingEventHandlers).Count -ne 1 -or @($pair.missingComponentFields).Count -ne 1) { throw 'Contagem inesperada no diagnóstico PAS/DFM.' }
    & (Join-Path $PSScriptRoot 'summarize-delphi-build.ps1') -InputPath (Join-Path $lab 'build-fixture.log') -OutputPath (Join-Path $temp 'build.json')
    $build=Get-Content -Raw (Join-Path $temp 'build.json') | ConvertFrom-Json
    if ($build.errorCount -ne 1 -or $build.warningCount -ne 2) { throw 'Resumo do build didático divergiu do esperado.' }
    Write-Host 'OK: laboratório detectou 1 evento ausente, 1 campo ausente, 1 erro e 2 warnings.'
} finally { if(Test-Path $temp){Remove-Item -LiteralPath $temp -Recurse -Force} }
