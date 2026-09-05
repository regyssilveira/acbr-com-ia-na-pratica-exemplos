---
name: acbr-component-work
description: Localize APIs, demos and impacts de versão ao trabalhar diretamente com componentes ACBr em projetos Delphi. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Trabalho com componentes ACBr

Antes de propor código, identifique a versão do Delphi, a revisão do ACBr, a plataforma e os paths efetivamente usados pelo projeto.

## Fluxo

1. Leia as instruções e a linha de base do repositório.
2. Localize o símbolo nos fontes da revisão declarada com `scripts/locate-acbr-symbol.ps1`.
3. Procure uso em demos da mesma árvore.
4. Informe unit, declaração e demo usados como evidência.
5. Faça a menor alteração que preserve PAS/DFM e a separação arquitetural.
6. Aplique o gate correspondente em [validation-gates.md](references/validation-gates.md).

Leia [source-map.md](references/source-map.md) quando precisar decidir onde pesquisar na árvore ACBr.

## Limites

- Não invente propriedade, enumeração ou assinatura ausente na revisão observada.
- Não decida tributação; mapeie somente valores aprovados e cite sua origem.
- Não exponha certificado, senha, XML ou dado real.
- Não execute emissão ou evento externo sem autorização explícita e ambiente conferido.
- Registre como não verificada qualquer plataforma que não tenha sido compilada.
