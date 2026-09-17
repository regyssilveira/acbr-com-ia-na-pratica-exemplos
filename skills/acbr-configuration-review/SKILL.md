---
name: acbr-configuration-review
description: Revise configurações de componentes ACBr em Delphi, comparando PAS, DFM, arquivos externos, ambientes, providers e valores efetivos sem expor credenciais.
---

# Revisão de configuração

1. Identifique onde cada valor nasce: padrão do componente, DFM, código, INI, variável ou entrada do usuário.
2. Registre a ordem de precedência e o valor efetivo sanitizado.
3. Compare ambiente, UF/provider, paths, schemas, timeouts, SSL, impressão e plataforma com a demo da mesma revisão.
4. Separe configuração técnica de regra fiscal ou contrato comercial.
5. Detecte valores silenciosamente herdados e divergências entre desenvolvimento, homologação e produção.

Não copie certificados, senhas, tokens ou arquivos locais. Não converta ausência de configuração em padrão fiscal inventado.

Avalie com [eval-cases.md](references/eval-cases.md).
