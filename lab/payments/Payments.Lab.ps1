param(
    [string]$Fixture = (Join-Path $PSScriptRoot '..\..\fixtures\payment-scenarios.json')
)

$ErrorActionPreference = 'Stop'
$data = Get-Content -Raw -LiteralPath $Fixture | ConvertFrom-Json
$allowed = @{
    'created/timeout_after_submit' = 'uncertain'
    'created/provider_rejected' = 'rejected'
    'draft/document_generated' = 'generated_not_registered'
    'generated_not_registered/bank_registration_confirmed' = 'registered'
}

foreach ($scenario in $data.scenarios) {
    $key = "$($scenario.initial)/$($scenario.event)"
    if (-not $allowed.ContainsKey($key)) { throw "Transição não prevista: $key" }
    $actual = $allowed[$key]
    if ($actual -ne $scenario.expected) { throw "Estado divergente em $($scenario.id): $actual" }
    if ($actual -eq 'uncertain' -and $scenario.retryAllowed) { throw "Retry indevido em resultado incerto: $($scenario.id)" }
    if ($scenario.kind -eq 'boleto' -and $scenario.event -eq 'document_generated' -and $actual -eq 'registered') {
        throw "Documento gerado não pode provar registro bancário."
    }
    Write-Host "$($scenario.id): $($scenario.initial) -> $actual"
    if ($actual -eq 'uncertain') {
        if (-not $scenario.queryResult) { throw "Resultado incerto sem consulta simulada: $($scenario.id)" }
        Write-Host "$($scenario.id): consulta simulada -> $($scenario.queryResult); nova cobrança bloqueada"
    }
}

Write-Host "OK: $($data.scenarios.Count) cenários locais de pagamento validados; nenhuma transação externa executada."
