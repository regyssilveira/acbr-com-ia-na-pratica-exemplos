param([Parameter(Mandatory)] [string]$PasFile, [string]$DfmFile, [string]$OutputPath)
$ErrorActionPreference = 'Stop'
$pas = (Resolve-Path -LiteralPath $PasFile).Path
if (-not $DfmFile) { $DfmFile = [IO.Path]::ChangeExtension($pas, '.dfm') }
$dfm = (Resolve-Path -LiteralPath $DfmFile).Path
$pasText = Get-Content -Raw -LiteralPath $pas
$dfmText = Get-Content -Raw -LiteralPath $dfm
$events = @([regex]::Matches($dfmText, '(?m)^\s*On\w+\s*=\s*(\w+)\s*$') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
$missing = @($events | Where-Object { $pasText -notmatch ("(?im)\b(procedure|function)\s+\w+\." + [regex]::Escape($_) + "\b") })
$objects = @([regex]::Matches($dfmText, '(?m)^\s*(?:object|inherited)\s+(\w+)\s*:\s*(\w+)') | ForEach-Object { [pscustomobject]@{name=$_.Groups[1].Value; class=$_.Groups[2].Value} } | Select-Object -Skip 1)
$missingFields = @($objects | Where-Object { $pasText -notmatch ("(?im)^\s*" + [regex]::Escape($_.name) + "\s*:\s*" + [regex]::Escape($_.class) + "\s*;") })
$report = [pscustomobject]@{ pas=$pas; dfm=$dfm; events=$events.Count; missingEventHandlers=$missing; missingComponentFields=$missingFields; readOnly=$true }
if ($OutputPath) { $report | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $OutputPath -Encoding utf8 } else { $report | ConvertTo-Json -Depth 5 }
if ($missing.Count -or $missingFields.Count) { exit 2 }
