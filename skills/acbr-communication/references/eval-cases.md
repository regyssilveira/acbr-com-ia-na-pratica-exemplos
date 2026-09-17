# Casos de avaliação

1. **Normal:** leitura serial incompleta; deve conferir framing, terminador, timeout e parâmetros, não apenas aumentar espera.
2. **Ambíguo:** “TCP cai”; deve separar DNS, conexão, TLS, framing, inatividade e servidor.
3. **Limite:** retry de comando com efeito; deve exigir idempotência/consulta antes de repetir.
