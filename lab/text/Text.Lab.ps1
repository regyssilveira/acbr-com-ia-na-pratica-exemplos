param(
    [string]$Fixture = (Join-Path $PSScriptRoot '..\..\fixtures\text-obligation-fictional.json'),
    [string]$Output = (Join-Path $PSScriptRoot '..\output\obligation-fictional.txt')
)

$ErrorActionPreference = 'Stop'
$data = Get-Content -Raw -LiteralPath $Fixture | ConvertFrom-Json
if ($data.layout -ne 'LAB-TXT-1') { throw "Leiaute não suportado pelo laboratório: $($data.layout)" }
if (@($data.records).Count -lt 3) { throw 'Fixture sem registros suficientes.' }
if ($data.records[0].type -ne '0000' -or $data.records[-1].type -ne '9999') { throw 'Abertura ou encerramento ausente.' }

$seen = [System.Collections.Generic.HashSet[string]]::new()
$lines = [System.Collections.Generic.List[string]]::new()
foreach ($record in $data.records) {
    if ($record.parent -and -not $seen.Contains([string]$record.parent)) { throw "Pai ausente antes de $($record.type): $($record.parent)" }
    $null = $seen.Add([string]$record.type)
    $amount = ([decimal]$record.amount).ToString('0.00', [Globalization.CultureInfo]::InvariantCulture)
    $lines.Add("|$($record.type)|$($record.parent)|$($record.code)|$amount|")
}

$details = @($data.records | Where-Object type -eq 'C190' | Measure-Object -Property amount -Sum).Sum
$closing = [decimal]$data.records[-1].amount
if ([decimal]$details -ne $closing) { throw "Total divergente: detalhes=$details encerramento=$closing" }

$outputFull = [IO.Path]::GetFullPath($Output)
$labRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not $outputFull.StartsWith($labRoot, [StringComparison]::OrdinalIgnoreCase)) { throw "Saída fora do laboratório: $outputFull" }
$directory = Split-Path $outputFull -Parent
if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory | Out-Null }
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllLines($outputFull, $lines, $utf8NoBom)

$bytes = [IO.File]::ReadAllBytes($outputFull)
$roundTrip = [Text.UTF8Encoding]::new($false, $true).GetString($bytes)
if ($roundTrip -notmatch '^\|0000\|' -or $roundTrip -notmatch '(?m)^\|9999\|') { throw 'Arquivo gerado não passou no round-trip UTF-8.' }

Write-Host "OK: $($lines.Count) registros, hierarquia, total $closing e UTF-8 validados em $outputFull."
Write-Host 'Limite: este leiaute é didático e não substitui obrigação ou validador oficial.'
