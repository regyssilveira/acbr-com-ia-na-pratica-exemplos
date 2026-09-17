---
name: acbr-response-handling
description: Modele e revise o tratamento de retornos ACBr no Delphi, distinguindo sucesso, rejeição, falha técnica, duplicidade, timeout e resultado incerto com idempotência.
---

# Tratamento de respostas

1. Liste estados do domínio e evidências que permitem cada transição.
2. Preserve código, mensagem, protocolo/identificador e payload sanitizado quando necessário.
3. Separe rejeição de negócio, erro de validação, transporte, indisponibilidade e exceção local.
4. Para timeout, queda ou resposta incompleta, marque resultado incerto e consulte antes de repetir.
5. Faça UI, persistência e retry refletirem o mesmo estado.

Não trate ausência de exceção como sucesso nem mensagem textual como único critério quando há código ou protocolo estruturado.

Avalie com [eval-cases.md](references/eval-cases.md).
