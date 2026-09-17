param(
    [Parameter(Mandatory)] [string]$Query,
    [switch]$AsJson
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$catalog = Get-Content -Raw (Join-Path $root 'skills/catalog.json') | ConvertFrom-Json
$recipes = Get-Content -Raw (Join-Path $root 'skills/recipes.md')

$aliases = @{
    'acbr-project-onboarding' = 'conhecer projeto arquitetura legado entrada onboarding mapa'
    'acbr-integration-start' = 'começar iniciar integrar componente exemplo demo'
    'acbr-problem-diagnosis' = 'erro problema falha rejeição timeout diagnosticar analisar'
    'acbr-change-review' = 'revisar diff mudança pas dfm pull request'
    'acbr-environment-setup' = 'instalar ambiente path dcu delphi configuração'
    'acbr-version-update' = 'atualizar revisão svn versão migração compatibilidade'
    'acbr-build-troubleshooting' = 'compilar build unit não encontrada linker dcu'
    'acbr-runtime-diagnosis' = 'execução access violation travamento runtime exceção'
    'acbr-test-design' = 'teste dunitx cenário homologação fixture'
    'acbr-configuration-review' = 'configurar certificado ssl ambiente propriedade ini'
    'acbr-response-handling' = 'retorno resposta status código mensagem webservice'
    'acbr-logging-evidence' = 'log evidência rastrear reproduzir suporte'
    'acbr-performance-review' = 'lento desempenho memória processamento lote'
    'acbr-security-review' = 'segurança segredo certificado senha token privacidade'
    'acbr-support-request' = 'pedir ajuda suporte fórum issue pacote diagnóstico'
    'acbr-dfe' = 'nfe nfce cte mdfe nfse documento fiscal xml sefaz rejeição'
    'acbr-payments' = 'boleto pix tef pagamento cobrança banco psp'
    'acbr-fiscal-devices' = 'sat equipamento fiscal ativação sessão'
    'acbr-text-obligations' = 'sped sintegra txt obrigação registro bloco'
    'acbr-printing' = 'posprinter imprimir impressão escpos bobina'
    'acbr-communication' = 'serial tcp porta comunicação dispositivo conexão cep endereço email e-mail smtp balança peso'
}

$terms = @($Query.ToLowerInvariant() -split '[^\p{L}\p{Nd}]+' | Where-Object Length -ge 3 | Sort-Object -Unique)
$ranked = foreach ($entry in $catalog.entries) {
    $haystack = (($entry.id + ' ' + $aliases[$entry.id]) -replace '[-_]', ' ').ToLowerInvariant()
    $score = 0
    foreach ($term in $terms) {
        if ($haystack -match [regex]::Escape($term)) { $score += 2 }
        if ($entry.id -match [regex]::Escape($term)) { $score += 1 }
    }
    if ($score -gt 0) {
        $recipeMatches = @([regex]::Matches($recipes, "(?im)^.*$([regex]::Escape($entry.id)).*$") | ForEach-Object Value | Select-Object -First 3)
        [pscustomobject]@{ skill = $entry.id; kind = $entry.kind; state = $entry.state; score = $score; recipes = $recipeMatches }
    }
}

$result = @($ranked | Sort-Object @{Expression='score';Descending=$true}, skill | Select-Object -First 5)
if ($result.Count -eq 0) {
    $result = @([pscustomobject]@{ skill='acbr-component-work'; kind='router'; state='RV'; score=0; recipes=@() })
}

if ($AsJson) { $result | ConvertTo-Json -Depth 5 } else {
    Write-Host "Consulta: $Query"
    $result | Format-Table skill, kind, state, score -AutoSize
    Write-Host 'Comece pela primeira skill. Se o contexto ainda estiver incompleto, use acbr-component-work para triagem.'
}
