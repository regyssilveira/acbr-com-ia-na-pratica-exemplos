$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$catalog = Get-Content -Raw -LiteralPath (Join-Path $root 'skills\catalog.json') | ConvertFrom-Json
$queuePath = Join-Path $root 'manifest\evidence\evaluations\expansion-2026-09-17\queue.json'
$queue = Get-Content -Raw -LiteralPath $queuePath | ConvertFrom-Json
$queued = @($queue.batches | ForEach-Object { $_.skills })

if ($queued.Count -ne @($queued | Sort-Object -Unique).Count) { throw 'Há skills duplicadas na fila de avaliação.' }
$targetEntries = @($catalog.entries | Where-Object { $_.id -in $queued })
$unknown = @($queued | Where-Object { $_ -notin @($catalog.entries.id) })
if ($unknown.Count -gt 0) { throw "Fila contém skill desconhecida: $($unknown -join ', ')" }
if ($queue.expectedSkills -ne $targetEntries.Count) { throw 'Contagem esperada de skills divergente.' }
if ($queue.expectedCases -ne ($targetEntries.Count * $queue.caseLabels.Count)) { throw 'Contagem esperada de casos divergente.' }

foreach ($entry in $targetEntries) {
    $casesPath = Join-Path $root "skills\$($entry.id)\references\eval-cases.md"
    if (-not (Test-Path -LiteralPath $casesPath -PathType Leaf)) { throw "Casos ausentes: $($entry.id)" }
    $text = [IO.File]::ReadAllText($casesPath, [Text.Encoding]::UTF8)
    foreach ($label in @('Normal', 'Ambíguo', 'Limite')) {
        if ($text -notmatch [regex]::Escape($label)) { throw "Caso '$label' ausente: $($entry.id)" }
    }
}

if ($queue.status -eq 'pending-independent-sessions') {
    $notPending = @($targetEntries | Where-Object state -ne 'IM')
    if ($notPending.Count -gt 0) { throw "Skill promovida antes da avaliação: $($notPending.id -join ', ')" }
    Write-Host "OK: $($targetEntries.Count) skills IM e $($queue.expectedCases) casos estão cobertos pela fila independente."
    Write-Host 'Pendente: execução em sessões independentes antes da promoção para RV.'
}
elseif ($queue.status -eq 'complete') {
    $notReviewed = @($targetEntries | Where-Object state -ne 'RV')
    if ($notReviewed.Count -gt 0) { throw "Skill avaliada sem estado RV: $($notReviewed.id -join ', ')" }
    if (@($queue.reports).Count -ne @($queue.batches).Count) { throw 'Quantidade de relatórios divergente dos lotes.' }
    foreach ($batch in $queue.batches) {
        $reportName = "$($batch.id)-evaluation.md"
        if ($reportName -notin $queue.reports) { throw "Relatório não declarado: $reportName" }
        $reportPath = Join-Path (Split-Path $queuePath -Parent) $reportName
        if (-not (Test-Path -LiteralPath $reportPath -PathType Leaf)) { throw "Relatório ausente: $reportName" }
        $report = [IO.File]::ReadAllText($reportPath, [Text.Encoding]::UTF8)
        if ($report -match '(?i)\bFAIL\b') { throw "Relatório contém falha: $reportName" }
        foreach ($skill in $batch.skills) {
            if ($report -notmatch [regex]::Escape($skill)) { throw "Skill ausente no relatório ${reportName}: $skill" }
        }
        if ([regex]::Matches($report, '3/3').Count -lt @($batch.skills).Count) {
            throw "Relatório sem síntese 3/3 para todas as skills: $reportName"
        }
    }
    Write-Host "OK: $($targetEntries.Count) skills RV e $($queue.expectedCases) casos aprovados em quatro relatórios independentes."
}
else { throw "Estado desconhecido da fila: $($queue.status)" }
