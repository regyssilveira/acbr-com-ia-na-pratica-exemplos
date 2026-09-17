param([Parameter(Mandatory)] [string]$InputPath, [string]$OutputPath)
$ErrorActionPreference = 'Stop'
$lines = Get-Content -LiteralPath $InputPath
$errors = @($lines | Where-Object { $_ -match '(?i)\b(error|fatal)\b|E\d{4}' })
$warnings = @($lines | Where-Object { $_ -match '(?i)\bwarning\b|W\d{4}' })
$units = @([regex]::Matches(($lines -join "`n"), '(?i)unit [''"]?([\w.]+)') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
$report = [pscustomobject]@{ firstError=($errors | Select-Object -First 1); errorCount=$errors.Count; warningCount=$warnings.Count; warnings=$warnings; mentionedUnits=$units; source=$InputPath }
if ($OutputPath) { $report | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $OutputPath -Encoding utf8 } else { $report | ConvertTo-Json -Depth 5 }
