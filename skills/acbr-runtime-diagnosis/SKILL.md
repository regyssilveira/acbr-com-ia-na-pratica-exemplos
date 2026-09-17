---
name: acbr-runtime-diagnosis
description: Investigue falhas em execução com componentes ACBr no Delphi, incluindo exceções, timeout, travamento, encoding e diferenças entre IDE e executável, usando reprodução de baixo risco.
---

# Diagnóstico em execução

Produza uma reprodução mínima antes de propor correção.

1. Separe sintoma, etapa, ambiente, entrada fictícia e resultado esperado.
2. Compare execução pela IDE e pelo binário, incluindo diretório atual, arquivos carregados e arquitetura.
3. Capture exceção completa, call stack, thread e último estado conhecido.
4. Para timeout ou resultado incerto, consulte o estado antes de repetir uma operação.
5. Para texto corrompido, siga bytes: fonte, DFM/configuração, compilador, transporte e renderização.
6. Teste uma hipótese por vez e registre o resultado que a confirma ou elimina.

Não reproduza com certificado, documento ou operação real quando um dublê local puder demonstrar o problema. Não converta exceção em `try/except` silencioso.

Para avaliação, leia [eval-cases.md](references/eval-cases.md).
