---
name: acbr-payments
description: Oriente integrações Delphi ACBr de cobrança e pagamento, incluindo Boleto, PIX e TEF, com foco em providers, credenciais, estados transacionais, idempotência e conciliação.
---

# Cobranças e pagamentos

Use esta família com uma skill de tarefa e carregue apenas a referência aplicável:

- [Boleto](references/boleto.md)
- [PIXCD](references/pixcd.md)
- [TEF](references/tef.md)

Confirme revisão, componente/provider, ambiente, credenciais, identificadores transacionais e documentação contratual. Modele estados explícitos: criado, pendente, confirmado, rejeitado, cancelado, expirado e incerto, conforme o domínio observado.

Nunca registre segredo, token, chave privada, payload integral ou dado financeiro real. Timeout não prova falha; consulte pelo identificador antes de repetir. Não simule aprovação como se viesse do provedor.

Avalie com [eval-cases.md](references/eval-cases.md).
