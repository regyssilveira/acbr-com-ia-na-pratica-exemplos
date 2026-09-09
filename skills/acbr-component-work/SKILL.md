---
name: acbr-component-work
description: Inicie integrações, localize APIs e demos, diagnostique falhas e revise impactos de versão ao trabalhar diretamente com componentes ACBr em projetos Delphi. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Trabalho com componentes ACBr

Antes de propor código, identifique a versão do Delphi, a revisão do ACBr, a plataforma e os paths efetivamente usados pelo projeto.

Quando o pedido chegar incompleto, leia [task-intake.md](references/task-intake.md) e reúna somente o contexto que muda a investigação.

## Fluxo

1. Leia as instruções e a linha de base do repositório.
2. Quando necessário, inventarie a linha de base com `scripts/inspect-acbr-baseline.ps1`.
3. Localize o símbolo nos fontes da revisão declarada com `scripts/locate-acbr-symbol.ps1`.
4. Procure uso em demos da mesma árvore.
5. Separe fatos, hipóteses e lacunas antes de propor alteração.
6. Faça a menor mudança que preserve PAS/DFM e a separação arquitetural.
7. Aplique o gate correspondente em [validation-gates.md](references/validation-gates.md).

Leia [source-map.md](references/source-map.md) quando precisar decidir onde pesquisar na árvore ACBr.

- Para erros, retornos e comportamento divergente, leia [diagnostic-playbook.md](references/diagnostic-playbook.md).
- Para formulários, DataModules, eventos ou componentes, leia [pas-dfm-review.md](references/pas-dfm-review.md).
- Para certificados, dados fiscais e efeitos externos, leia [security-boundaries.md](references/security-boundaries.md).
- Ao alterar a própria skill, execute os casos de [eval-cases.md](references/eval-cases.md).

## Limites

- Não invente propriedade, enumeração ou assinatura ausente na revisão observada.
- Não decida tributação; mapeie somente valores aprovados e cite sua origem.
- Não exponha certificado, senha, XML ou dado real.
- Não execute emissão ou evento externo sem autorização explícita e ambiente conferido.
- Registre como não verificada qualquer plataforma que não tenha sido compilada.
- Não transforme ausência de informação em valor padrão ou decisão fiscal.
