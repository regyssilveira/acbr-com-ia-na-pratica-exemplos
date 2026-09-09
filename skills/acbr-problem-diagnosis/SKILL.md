---
name: acbr-problem-diagnosis
description: Investigue erros, rejeições e comportamentos divergentes em projetos Delphi com componentes ACBr, produzindo hipóteses ordenadas e o próximo teste de menor risco. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Diagnóstico de problemas ACBr

O objetivo inicial é reduzir a incerteza, não corrigir por tentativa. Preserve o erro exato e estabeleça uma execução bem-sucedida para comparação sempre que possível.

## Coleta mínima

Registre versão do aplicativo, Delphi, revisão ACBr, plataforma, componente, ambiente, etapa que falhou, resultado esperado, retorno completo e última execução conhecida como boa. Anonimize XMLs, logs e imagens antes de compartilhá-los.

## Método

1. Reproduza localmente ou declare por que a reprodução não foi possível.
2. Classifique a falha: compilação, carga, configuração, certificado, schema, comunicação, retorno do serviço, mapeamento ou ciclo de vida visual.
3. Compare execução boa e ruim, mudando uma variável por vez.
4. Em falha visual, compare o par PAS/DFM e verifique classe, herança, criação, eventos e ordem de vida.
5. Confira símbolos e comportamento nos fontes e demos da revisão instalada e confirme quais paths ou DCUs o build resolveu.
6. Ordene hipóteses pela evidência e proponha o teste de menor custo e risco, sem efeito externo, que consiga refutar a primeira.

Entregue fatos observados, lacunas e hipóteses ordenadas. Para cada hipótese, registre evidência favorável, evidência contrária ou ausente, teste discriminador e resultado. Termine com critério de conclusão e evidências a preservar. Não altere path ou DCU durante o diagnóstico inicial, não converta rejeição em regra fiscal própria e não chame serviço externo sem autorização.

Ao alterar esta skill, execute os casos de [eval-cases.md](references/eval-cases.md).
