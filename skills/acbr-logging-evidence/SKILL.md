---
name: acbr-logging-evidence
description: Produza evidências e logs mínimos para problemas Delphi com ACBr, preservando sequência, revisão e códigos úteis enquanto remove segredos e dados fiscais pessoais.
---

# Logs e evidências

Monte uma linha do tempo curta com versão, revisão, plataforma, componente, operação, identificador sanitizado, duração, código e mensagem. Inclua o primeiro erro determinante e o resultado de cada teste.

Antes de compartilhar:

- remova certificados, chaves, tokens, senhas, documentos, nomes, endereços e XML integral;
- preserve estrutura, códigos, timestamps relativos e correlação necessários;
- identifique claramente conteúdo simulado;
- não edite a evidência de modo que esconda warnings ou tentativas anteriores.

Produza uma cópia sanitizada; não destrua o original necessário ao diagnóstico local.

No repositório de exemplos, `scripts/sanitize-acbr-log.ps1` cria a cópia e um relatório sem sobrescrever o original. A automação reduz exposição acidental, mas não substitui a revisão humana.

Avalie com [eval-cases.md](references/eval-cases.md).
