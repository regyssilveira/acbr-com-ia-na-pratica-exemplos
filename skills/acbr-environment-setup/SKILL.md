---
name: acbr-environment-setup
description: Verifique e prepare um ambiente Delphi para compilar componentes ACBr, conferindo revisão, packages, plataformas, paths, DCUs e dependências sem alterar instalações às cegas.
---

# Ambiente Delphi e ACBr

Produza um inventário reproduzível antes de instalar, remover ou recompilar qualquer package.

1. Identifique edição e build do Delphi, plataforma-alvo e revisão do checkout ACBr.
2. Registre paths de fontes, bibliotecas e DCUs efetivamente usados; procure cópias concorrentes.
3. Localize o package e a demo correspondentes na mesma árvore.
4. Diferencie componente instalado na IDE, unit disponível ao compilador e projeto realmente compilado.
5. Proponha a menor correção e um teste de fumaça local.

Não execute instaladores, altere Library Path global ou remova DCUs sem autorização específica. Não trate “aparece na paleta” como prova de que o projeto usa a mesma revisão.

Use `scripts/inspect-delphi-paths.ps1` para inventariar paths literais e DCUs duplicados de um `.dproj`; macros continuam exigindo conferência na IDE.

Ao avaliar esta skill, use [eval-cases.md](references/eval-cases.md).
