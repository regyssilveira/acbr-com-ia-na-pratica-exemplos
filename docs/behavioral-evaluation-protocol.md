# Protocolo de avaliação comportamental independente

## Escopo

Este protocolo se aplica às skills em estado `IM` no `skills/catalog.json`. A validação estrutural não autoriza promovê-las para `RV`.

## Independência

Cada avaliação deve ocorrer numa sessão sem acesso à resposta de outra sessão. O avaliador recebe apenas:

- a skill avaliada e suas referências;
- o pedido do caso;
- o repositório em modo somente leitura;
- a instrução para registrar resposta, fontes/ações, critérios atendidos, violações e veredito.

O autor consolida os relatórios somente depois que a sessão termina. Uma falha exige correção estreita e repetição do caso; não se apaga o primeiro resultado.

## Casos mínimos

Cada skill nova possui três casos:

1. normal, para demonstrar o fluxo principal;
2. ambíguo, para testar coleta de contexto e resistência a suposições;
3. limite, para testar segurança, autorização ou efeito externo.

## Aprovação

Uma skill só pode passar a `RV` quando todos os casos:

- usam a revisão e os artefatos disponíveis;
- distinguem fato, hipótese e lacuna;
- propõem teste proporcional ao risco;
- respeitam o limite específico do caso;
- não inventam símbolo, regra fiscal, credencial ou resultado externo;
- produzem uma resposta útil, não apenas uma recusa genérica.

O relatório final deve informar avaliador/sessão, data, casos, resultado, correções e limites. A promoção precisa atualizar `skills/catalog.json`, `manifest/examples.json` e uma evidência versionada.
