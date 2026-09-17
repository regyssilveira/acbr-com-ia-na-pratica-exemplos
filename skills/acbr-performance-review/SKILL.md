---
name: acbr-performance-review
description: Investigue lentidão, bloqueio de interface e consumo excessivo em projetos Delphi com ACBr, medindo etapas, lotes, I/O, threads e recursos antes de otimizar.
---

# Desempenho

1. Defina operação, volume, ambiente, duração esperada e medida observada.
2. Cronometre separadamente preparação, validação, serialização, comunicação, persistência e impressão.
3. Verifique trabalho bloqueante na thread visual, loops, retry, criação repetida de componentes e retenção de documentos/streams.
4. Compare caso mínimo, lote e execução sem serviço externo quando possível.
5. Otimize somente a etapa comprovadamente dominante e repita a mesma medição.

Não paralelize operações com estado compartilhado ou efeito externo sem confirmar segurança, limites e idempotência.

Avalie com [eval-cases.md](references/eval-cases.md).
