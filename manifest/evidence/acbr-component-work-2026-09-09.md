# Evidência da skill acbr-component-work

- Data: 9 de setembro de 2026.
- Escopo: estrutura, scripts e integração com o piloto local.
- Validador estrutural: `quick_validate.py` do criador de skills; resultado aprovado.
- Busca: `locate-acbr-symbol.ps1` executado para `ModeloDF` contra checkout ACBr SVN; ACBrLib e ACBrMonitorPLUS ausentes do resultado após correção dos globs.
- Inventário: `inspect-acbr-baseline.ps1` identificou checkout SVN, revisão, DPR e arquivos do Caixa Ágil com referências ACBr.
- Pipeline: `scripts/validate-all.ps1` concluiu build Win32, oito testes DUnitX, três cenários locais e verificação de segredos.
- Operações externas: nenhuma.

## Limites

- A revisão SVN observada no teste da skill foi 48154; o projeto do livro permanece ligado à linha de base compilada e documentada na revisão 47874.
- Os sete casos em `references/eval-cases.md` são critérios de avaliação manual; não constituem suíte automatizada de respostas de modelos.
- Win64 e comunicação real com a SEFAZ não foram validados.
