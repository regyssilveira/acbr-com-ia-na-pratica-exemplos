---
name: acbr-integration-start
description: Planeje e inicie uma integração Delphi com componentes ACBr a partir da revisão instalada, usando fontes e demos reais e separando configuração técnica de decisão fiscal. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Início de integração ACBr

Transforme o objetivo em uma primeira entrega pequena, compilável e verificável. Antes do código, confirme Delphi, revisão ACBr, plataforma, componente, ambiente e resultado mínimo esperado.

## Fontes de verdade

1. Localize o componente, suas units e assinaturas nos fontes da revisão instalada.
2. Procure a demonstração mais próxima na mesma árvore do ACBr.
3. Compare a demonstração com a arquitetura do projeto; não copie formulário ou regra fiscal sem adaptação.
4. Registre propriedades, eventos e tipos realmente encontrados.

## Primeira entrega

Proponha a menor fatia vertical que:

- mantém componentes ACBr em DataModule ou camada de infraestrutura;
- recebe dados do domínio sem inventar tributação;
- usa homologação e dados fictícios;
- pode ser compilada e testada sem efeito fiscal externo;
- deixa explícitos os campos e decisões ainda pendentes.

Forneça plano de arquivos, contratos, configuração, critérios de aceite e comandos de validação. Só implemente quando o pedido autorizar alteração. Não transmita, cancele, inutilize ou consulte serviço externo sem autorização explícita e ambiente conferido.

Ao alterar esta skill, execute os casos de [eval-cases.md](references/eval-cases.md).
