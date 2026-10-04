param()
$ErrorActionPreference = 'Stop'
$tempRoot = Join-Path ([IO.Path]::GetTempPath()) ('acbr-gate-' + [guid]::NewGuid().ToString('N'))
$expectedRoot = Join-Path $PSScriptRoot '../lab/diagnostics/expected'
$pas = Get-Content -LiteralPath (Join-Path $expectedRoot 'BrokenForm.pas') -Raw
$dfm = Get-Content -LiteralPath (Join-Path $expectedRoot 'BrokenForm.dfm') -Raw
$cases = @(
    @{name='missing-declaration'; pas=$pas.Replace('    procedure MissingClick(Sender: TObject);',''); dfm=$dfm},
    @{name='comment-declaration'; pas=$pas.Replace('    procedure MissingClick(Sender: TObject);','    // procedure MissingClick(Sender: TObject);'); dfm=$dfm},
    @{name='missing-implementation'; pas=$pas.Replace('procedure TBrokenForm.MissingClick(Sender: TObject);','procedure TBrokenForm.OtherClick(Sender: TObject);'); dfm=$dfm},
    @{name='wrong-field-type'; pas=$pas.Replace('ACBrNFe1: TACBrNFe;','ACBrNFe1: TObject;'); dfm=$dfm},
    @{name='empty-dfm'; pas=$pas; dfm="object BrokenForm: TBrokenForm`nend"},
    @{name='removed-event'; pas=$pas; dfm=$dfm.Replace('OnClick = MissingClick','')},
    @{name='wrong-event'; pas=$pas; dfm=$dfm.Replace('OnClick = MissingClick','OnClick = OtherClick')},
    @{name='wrong-root'; pas=$pas; dfm=$dfm.Replace('object BrokenForm:', 'object OtherForm:')}
)
try {
    New-Item -ItemType Directory -Path $tempRoot | Out-Null
    & (Join-Path $PSScriptRoot 'test-diagnostics-exercise.ps1') -InputDirectory $expectedRoot
    foreach ($case in $cases) {
        $caseRoot = Join-Path $tempRoot $case.name
        New-Item -ItemType Directory -Path $caseRoot | Out-Null
        [IO.File]::WriteAllText((Join-Path $caseRoot 'BrokenForm.pas'), $case.pas)
        [IO.File]::WriteAllText((Join-Path $caseRoot 'BrokenForm.dfm'), $case.dfm)
        $rejected = $false
        try { & (Join-Path $PSScriptRoot 'test-diagnostics-exercise.ps1') -InputDirectory $caseRoot }
        catch { $rejected = $true }
        if (-not $rejected) { throw "False approval: $($case.name)" }
        Write-Host "Rejected as expected: $($case.name)"
    }
    Write-Host 'OK: coherent pair accepted; eight incomplete corrections rejected.'
}
finally {
    $resolved = [IO.Path]::GetFullPath($tempRoot)
    $tempBase = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
    if (-not $resolved.StartsWith($tempBase, [StringComparison]::OrdinalIgnoreCase) -or (Split-Path $resolved -Leaf) -notlike 'acbr-gate-*') { throw 'Unsafe temporary cleanup target.' }
    if (Test-Path -LiteralPath $resolved) { Remove-Item -LiteralPath $resolved -Recurse -Force }
}
