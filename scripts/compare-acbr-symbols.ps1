param(
    [Parameter(Mandatory = $true)][string]$OldCheckout,
    [Parameter(Mandatory = $true)][string]$NewCheckout,
    [Parameter(Mandatory = $true)][string[]]$Pattern,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$oldRoot = (Resolve-Path -LiteralPath $OldCheckout).Path
$newRoot = (Resolve-Path -LiteralPath $NewCheckout).Path
$rg = (Get-Command rg -ErrorAction Stop).Source

function Get-SymbolSnapshot([string]$Root, [string]$Term) {
    $raw = @(& $rg --line-number --no-heading --color never --glob '*.pas' --glob '*.pp' --glob '*.inc' --glob '*.dpk' --glob '!**/ACBrLib/**' --glob '!**/ACBrMonitorPLUS/**' --fixed-strings -- $Term $Root)
    if ($LASTEXITCODE -gt 1) { throw "Falha na pesquisa de '$Term' em $Root" }
    return @($raw | ForEach-Object { $_.Replace($Root, '<ROOT>') } | Sort-Object -Unique)
}

$result = foreach ($term in $Pattern) {
    $oldLines = @(Get-SymbolSnapshot $oldRoot $term)
    $newLines = @(Get-SymbolSnapshot $newRoot $term)
    $removed = @($oldLines | Where-Object { $_ -notin $newLines })
    $added = @($newLines | Where-Object { $_ -notin $oldLines })
    [ordered]@{
        pattern = $term
        oldOccurrences = $oldLines.Count
        newOccurrences = $newLines.Count
        status = if ($oldLines.Count -eq 0 -and $newLines.Count -gt 0) {'added'} elseif ($oldLines.Count -gt 0 -and $newLines.Count -eq 0) {'removed'} elseif ($removed.Count -or $added.Count) {'changed'} else {'unchanged'}
        removed = $removed
        added = $added
    }
}

$json = $result | ConvertTo-Json -Depth 6
if ($OutputPath) {
    $outputFull = [IO.Path]::GetFullPath($OutputPath)
    if (Test-Path -LiteralPath $outputFull) { throw "A saída já existe: $outputFull" }
    $directory = Split-Path $outputFull -Parent
    if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory | Out-Null }
    [IO.File]::WriteAllText($outputFull, $json, [Text.UTF8Encoding]::new($false))
    Write-Host "OK: comparação gravada em $outputFull"
}
else { $json }
