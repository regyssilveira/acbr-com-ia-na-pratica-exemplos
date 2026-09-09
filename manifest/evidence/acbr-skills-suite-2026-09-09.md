# Evidência — suíte de skills ACBr

Data: 2026-09-09

Versão candidata: `pilot-v0.3.0`

## Escopo verificado

- skill geral `acbr-component-work` configurada como entrada da suíte;
- quatro skills especializadas com descrição discriminante e limites próprios;
- dezesseis novos casos de avaliação documentados;
- referências locais alcançáveis;
- ausência de placeholders de scaffold;
- ACBrLib e ACBrMonitorPLUS explicitamente fora do escopo.

## Gates executados

O comando `scripts/validate-all.ps1` foi executado na raiz do repositório e concluiu:

- build Delphi Win32 do Caixa Ágil;
- oito testes DUnitX aprovados;
- três cenários locais simulados;
- verificação de arquivos sensíveis rastreados;
- validação estrutural das cinco skills.

As cinco pastas também foram aprovadas por `quick_validate.py`, fornecido pela skill oficial de criação de skills do Codex.

## Resultado e limite

Todos os gates executados foram aprovados. As quatro skills novas permanecem no estado `IM`: sua estrutura e integração ao repositório foram verificadas, mas os casos comportamentais ainda devem ser aplicados a respostas independentes antes de promoção para `RV`. Nenhuma comunicação com serviço fiscal externo foi executada.
