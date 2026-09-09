---
name: acbr-change-review
description: Revise alterações em projetos Delphi com componentes ACBr, verificando API da revisão, pares PAS/DFM, arquitetura, segurança, efeitos externos e evidências antes da aceitação. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Revisão de mudanças ACBr

Revise o diff e os arquivos afetados, não apenas a descrição da mudança. Identifique primeiro o comportamento pretendido e a linha de base em que ele deve funcionar.

## Verificações

- confirme units, classes, propriedades, eventos e enumerações nos fontes da revisão ACBr declarada;
- revise PAS e DFM juntos quando um formulário ou DataModule for afetado;
- procure dependências de ordem de criação, ownership, eventos e componentes ausentes;
- mantenha UI, aplicação, domínio e infraestrutura separadas de acordo com a arquitetura existente;
- rejeite segredos, XMLs reais, dados de contribuintes e logs integrais;
- destaque transmissão, consulta, cancelamento, inutilização ou outro efeito externo novo;
- confira tratamento de erro, timeout, repetição, contingência e rastreabilidade quando aplicáveis;
- exija compilação, testes e cenário executado proporcionais à mudança.

Classifique achados por impacto, cite arquivo e trecho, explique o risco e indique a menor correção. Depois registre o que foi comprovado e o que permaneceu sem validação. Não aprove decisão fiscal apenas porque o código compila.

Ao alterar esta skill, execute os casos de [eval-cases.md](references/eval-cases.md).
