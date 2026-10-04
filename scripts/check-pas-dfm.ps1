param([Parameter(Mandatory)] [string]$PasFile, [string]$DfmFile, [string]$OutputPath)
$ErrorActionPreference = 'Stop'
$pas = (Resolve-Path -LiteralPath $PasFile).Path
if (-not $DfmFile) { $DfmFile = [IO.Path]::ChangeExtension($pas, '.dfm') }
$dfm = (Resolve-Path -LiteralPath $DfmFile).Path
$pasText = Get-Content -Raw -LiteralPath $pas
$dfmText = Get-Content -Raw -LiteralPath $dfm
# Structural screening only: comments and strings cannot provide declarations.
$pasCode = [regex]::Replace($pasText, "'(?:''|[^'])*'|//[^\r\n]*|\{[\s\S]*?\}|\(\*[\s\S]*?\*\)", ' ')
$root = [regex]::Match($dfmText, '(?m)^\s*(?:object|inherited)\s+(\w+)\s*:\s*(\w+)')
if (-not $root.Success) { throw 'DFM root object not found.' }
$rootClass = $root.Groups[2].Value
$classMatch = [regex]::Match($pasCode, '(?is)\b' + [regex]::Escape($rootClass) + '\s*=\s*class\s*\([^)]*\)(.*?)\bend\s*;')
if (-not $classMatch.Success) { throw "PAS class not found: $rootClass" }
$classBody = $classMatch.Groups[1].Value
$events = @([regex]::Matches($dfmText, '(?m)^\s*On\w+\s*=\s*(\w+)\s*$') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
$missingDeclarations = @($events | Where-Object { $classBody -notmatch ('(?im)\b(procedure|function)\s+' + [regex]::Escape($_) + '\s*(?:\(|;)') })
$missingImplementations = @($events | Where-Object { $pasCode -notmatch ('(?im)\b(procedure|function)\s+' + [regex]::Escape($rootClass) + '\.' + [regex]::Escape($_) + '\s*(?:\(|;)') })
$missing = @(@($missingDeclarations) + @($missingImplementations) | Sort-Object -Unique)
$objects = @([regex]::Matches($dfmText, '(?m)^\s*(?:object|inherited)\s+(\w+)\s*:\s*(\w+)') | ForEach-Object { [pscustomobject]@{name=$_.Groups[1].Value; class=$_.Groups[2].Value} } | Select-Object -Skip 1)
$missingFields = @($objects | Where-Object { $classBody -notmatch ("(?im)^\s*" + [regex]::Escape($_.name) + "\s*:\s*" + [regex]::Escape($_.class) + "\s*;") })
$report = [pscustomobject]@{ pas=$pas; dfm=$dfm; rootName=$root.Groups[1].Value; rootClass=$rootClass; objects=$objects; events=$events.Count; missingEventDeclarations=$missingDeclarations; missingEventImplementations=$missingImplementations; missingEventHandlers=$missing; missingComponentFields=$missingFields; readOnly=$true }
if ($OutputPath) { $report | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $OutputPath -Encoding utf8 } else { $report | ConvertTo-Json -Depth 5 }
