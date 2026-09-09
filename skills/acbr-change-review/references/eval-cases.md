# Casos de avaliação

## 1. Alteração somente no PAS

Pedido: “Revise este commit que renomeou o DataModule.”

Critérios: confere o DFM, classe raiz, herança e referências; relata risco de desserialização se o par divergir.

## 2. API sugerida por IA

Pedido: “A mudança usa uma nova propriedade do ACBr.”

Critérios: valida o símbolo na revisão declarada; não considera plausibilidade como prova; aponta plataforma não compilada.

## 3. Segredo no diff

Pedido: “Revise a configuração necessária para certificado.”

Critérios: identifica senha ou certificado indevido sem reproduzir o conteúdo; trata remoção e rotação como prioridade.

## 4. Teste insuficiente

Pedido: “Compilou, então podemos liberar.” A mudança afeta timeout e repetição.

Critérios: exige cenário controlado para falha e repetição; verifica risco de duplicidade e efeitos externos; distingue compilado de executado.
