---
name: acbr-version-update
description: Planeje e revise atualizações dos componentes ACBr em projetos Delphi, comparando revisões, símbolos, packages, migrações e evidências antes de aceitar a mudança.
---

# Atualização de versão ACBr

Trate atualização como mudança verificável, não como simples substituição de arquivos.

1. Registre revisão anterior e nova, Delphi, plataforma e origem dos DCUs.
2. Faça uma linha de base de build e testes antes da troca.
3. Compare símbolos usados pelo projeto com os fontes e demos da nova revisão.
4. Classifique quebras: package/path, assinatura, enumeração, comportamento, schema ou serviço.
5. Migre em incrementos pequenos e repita build, testes locais e revisão PAS/DFM.
6. Registre warnings novos e plataformas ainda não comprovadas.

Não atualize o checkout ACBr nem arquivos globais sem autorização. Não esconda adaptações com aliases ou cópias locais antes de confirmar a API correta.

Use `scripts/compare-acbr-symbols.ps1` quando precisar comparar ocorrências entre dois checkouts sem modificá-los.

Para avaliação, leia [eval-cases.md](references/eval-cases.md).
