---
name: acbr-security-review
description: Revise segurança em integrações Delphi com ACBr, procurando segredos, dados fiscais, logs, certificados, endpoints, permissões e efeitos externos antes de compartilhar ou executar.
---

# Segurança

1. Inventarie entradas sensíveis, local de armazenamento, carregamento, uso, log e descarte.
2. Procure certificados, chaves, senhas, tokens, CSC, códigos de ativação, XMLs e cadastros reais versionados ou exibidos.
3. Diferencie exemplo público, configuração local e segredo gerenciado externamente.
4. Verifique TLS, validação de origem, permissões mínimas e separação entre homologação e produção.
5. Classifique operações externas e exija autorização proporcional ao efeito.

Não mova nem revogue segredo sem autorização. Se houver exposição, informe o alvo exato e recomende rotação pelo responsável, sem repetir o valor.

Avalie com [eval-cases.md](references/eval-cases.md).
