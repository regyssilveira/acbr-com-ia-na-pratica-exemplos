# Casos de avaliação

1. **Normal:** retorno rejeitado com código; deve persistir estado e impedir fluxo de autorizado.
2. **Ambíguo:** chamada retorna `False`; deve localizar contrato e dados de retorno antes de classificar.
3. **Limite:** timeout após envio/pagamento; deve exigir consulta e idempotência antes de retry.
