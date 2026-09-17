---
name: acbr-build-troubleshooting
description: Diagnostique falhas de compilação e linking em projetos Delphi com ACBr, localizando unit, package, DCU, plataforma e revisão conflitantes antes de editar código.
---

# Diagnóstico de build

Comece pelo primeiro erro determinante e pelo comando ou configuração que o produziu.

1. Capture compilador, alvo, configuração, primeiro erro e paths efetivos.
2. Localize a unit ou símbolo nos fontes da revisão declarada.
3. Procure DCUs duplicados, artefatos de outra versão ou plataforma e ordem de busca inesperada.
4. Confira dependências do package e diferenças entre Build e Compile.
5. Só altere `uses` ou código quando a evidência excluir problema de ambiente.
6. Recompile do zero o alvo pertinente e preserve warnings na evidência.

Não sugira copiar DCUs entre versões ou adicionar a árvore inteira ao Library Path. Para pares visuais, preserve PAS/DFM.

O inventário somente leitura `scripts/inspect-delphi-paths.ps1` ajuda a localizar paths concorrentes e DCUs de mesmo nome antes de editar o projeto.

Para avaliação, leia [eval-cases.md](references/eval-cases.md).
