---
name: acbr-integration-start
description: Planeje e inicie uma integração Delphi com componentes ACBr a partir da revisão instalada, usando fontes e demos reais e separando configuração técnica de decisão fiscal. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Início de integração ACBr

Transforme o objetivo em uma primeira entrega pequena, compilável e verificável. Antes do código, confirme Delphi, revisão ACBr, plataforma, componente, ambiente e resultado mínimo esperado.

## Fontes de verdade

1. Localize o componente, suas units e assinaturas nos fontes da revisão instalada e demonstre que o projeto compila contra esses paths ou DCUs.
2. Procure a demonstração mais próxima na mesma árvore do ACBr.
3. Compare a demonstração com a arquitetura do projeto; não copie formulário ou regra fiscal sem adaptação.
4. Registre propriedades, eventos e tipos realmente encontrados.

## Primeira entrega

Proponha a menor fatia vertical que:

- mantém a interface visual como entrada e apresentação, a orquestração na aplicação, regras no domínio e componentes ACBr em DataModule ou infraestrutura, sem criar camadas desnecessárias;
- recebe dados do domínio sem inventar tributação;
- usa homologação e dados fictícios;
- pode ser compilada e testada sem efeito fiscal externo;
- deixa explícitos os campos e decisões ainda pendentes.

Forneça plano de arquivos, contratos, configuração, critérios de aceite e comandos de validação. Só implemente quando o pedido autorizar alteração. Antes de qualquer comunicação em homologação, exija ambiente, UF, endpoint, certificado de teste protegido, dados fictícios, efeito esperado e autorização explícita. Emissão em produção e fixtures derivadas de documentos reais ficam fora da primeira entrega.

Ao alterar esta skill, execute os casos de [eval-cases.md](references/eval-cases.md).
