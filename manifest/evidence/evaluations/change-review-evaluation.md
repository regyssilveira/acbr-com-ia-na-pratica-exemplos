## Caso 1 — Alteração somente no PAS

**Resposta ao usuário**

Não aprovaria a renomeação apenas pela alteração no `.pas`. É necessário revisar o `.dfm` correspondente e confirmar:

- nome da classe raiz no `object`/`inherited`;
- declaração e herança da classe no `.pas`;
- correspondência entre o nome do recurso DFM e a classe;
- variável global do DataModule, `Application.CreateForm` e demais referências;
- ordem de criação, ownership e eventos associados.

Se o `.pas` e o `.dfm` divergirem, há risco **alto** de falha na desserialização do formulário/DataModule, normalmente durante a criação do recurso. A menor correção é alinhar os dois arquivos e atualizar todas as referências antes de compilar e executar a inicialização.

**Fontes ou ações**

- Instrução de revisar PAS e DFM juntos: [SKILL.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/skills/acbr-change-review/SKILL.md:12>).
- Critérios do caso: [eval-cases.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/skills/acbr-change-review/references/eval-cases.md:3>).
- Ação necessária em uma revisão real: abrir o diff, o `.pas`, o `.dfm`, o `.dpr` e buscar todas as referências ao nome antigo e ao novo.

**Critérios atendidos**

- Confere o DFM.
- Confere classe raiz e herança.
- Confere referências e criação.
- Explicita o risco de desserialização.

**Violações ou lacunas**

- Nenhum commit ou par PAS/DFM foi fornecido; não é possível citar um trecho concreto nem confirmar a correção real.
- Essa ausência permanece registrada como evidência não validada, mas não impede a aprovação do comportamento da skill neste caso sintético.

**Veredito: PASS**

---

## Caso 2 — API sugerida por IA

**Resposta ao usuário**

A propriedade não pode ser aceita por parecer compatível com o ACBr. É preciso localizar sua declaração nos fontes oficiais da revisão SVN **47874**, confirmar a classe proprietária, tipo, visibilidade, units necessárias, disponibilidade condicional por plataforma e forma de uso nas demos correspondentes.

Depois disso, a mudança deve ser compilada nos alvos afetados. O manifesto registra que Win64 ainda não foi comprovado; portanto, uma compilação Win32 não autoriza afirmar compatibilidade Win64. Sem fonte da revisão e evidência de compilação, a propriedade permanece não validada.

**Fontes ou ações**

- Revisão ACBr declarada: [environment.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/docs/environment.md:3>).
- Limitação Win64 registrada: [examples.json](</D:/Livros/acbr-com-ia-na-pratica-exemplos/manifest/examples.json:10>).
- Exigência de confirmar símbolos nos fontes: [SKILL.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/skills/acbr-change-review/SKILL.md:10>).
- Ações necessárias: pesquisar a propriedade no checkout SVN 47874, inspecionar declarações condicionais e compilar Win32 e Win64 conforme o escopo.

**Critérios atendidos**

- Usa a revisão declarada como autoridade.
- Não trata plausibilidade nem sugestão de IA como prova.
- Aponta explicitamente a plataforma ainda não compilada.

**Violações ou lacunas**

- O nome da propriedade, classe e diff não foram fornecidos.
- O checkout ACBr externo não foi indicado como artefato acessível neste caso.
- Não há logs de compilação por plataforma.
- Em uma revisão real, essas lacunas impediriam a aprovação da mudança.

**Veredito: PASS**

---

## Caso 3 — Segredo no diff

**Resposta ao usuário**

Uma senha de certificado, chave privada ou certificado indevido no diff é um achado **bloqueador**. O conteúdo sensível não deve ser reproduzido no relatório.

A prioridade é:

1. remover o segredo do código e dos artefatos versionados;
2. revogar ou rotacionar imediatamente a credencial potencialmente exposta;
3. verificar o histórico e outros artefatos para determinar o alcance;
4. substituir o valor por configuração segura e documentada;
5. usar somente certificado e dados fictícios de homologação nos exemplos.

A simples remoção do arquivo atual não elimina uma credencial já exposta pelo histórico.

**Fontes ou ações**

- Proibição de segredos, certificados e dados reais: [AGENTS.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/AGENTS.md:13>).
- Rejeição de segredos e XMLs reais: [SKILL.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/skills/acbr-change-review/SKILL.md:14>).
- Ações necessárias: varredura do diff e histórico, remoção segura e rotação/revogação fora do repositório.

**Critérios atendidos**

- Identifica senha ou certificado como indevido.
- Não reproduz o conteúdo.
- Prioriza remoção e rotação.
- Classifica adequadamente como bloqueador.

**Violações ou lacunas**

- Não foi fornecido um diff real para identificar arquivo e linha.
- Não é possível confirmar o tipo de segredo, seu alcance ou se a rotação ocorreu.
- Não foi realizada qualquer ação externa, coerentemente com o modo somente leitura.

**Veredito: PASS**

---

## Caso 4 — Teste insuficiente

**Resposta ao usuário**

Não é seguro liberar apenas porque compilou. Mudanças em timeout e repetição precisam de cenário controlado que provoque demora, timeout, falha transitória e resposta tardia.

Os testes devem comprovar:

- número máximo de tentativas e intervalos;
- interrupção após o limite;
- comportamento diante de resposta tardia;
- idempotência ou consulta do estado antes de repetir;
- ausência de duplicidade quando a primeira tentativa pode ter sido processada;
- logs e correlação suficientes sem conteúdo fiscal sensível;
- comportamento final apresentado à aplicação.

Para operação fiscal ou outro efeito externo, o cenário deve usar doubles, ambiente controlado ou homologação expressamente autorizada e conferida. “Compilado” comprova apenas que o compilador aceitou o código; não comprova que o fluxo de timeout foi executado nem que a repetição é segura.

**Fontes ou ações**

- Exigência de tratamento de timeout e repetição: [SKILL.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/skills/acbr-change-review/SKILL.md:17>).
- Exigência de cenário executado e separação das evidências: [SKILL.md](</D:/Livros/acbr-com-ia-na-pratica-exemplos/skills/acbr-change-review/SKILL.md:18>).
- O manifesto informa que nenhuma operação fiscal externa foi executada: [examples.json](</D:/Livros/acbr-com-ia-na-pratica-exemplos/manifest/examples.json:10>).
- Ações necessárias: testes determinísticos com falha simulada, evidência de cada tentativa e verificação explícita de duplicidade.

**Critérios atendidos**

- Exige falha e repetição em cenário controlado.
- Verifica duplicidade e idempotência.
- Destaca os efeitos externos.
- Distingue compilação, execução e resultado comprovado.

**Violações ou lacunas**

- Não há diff, logs, testes ou relatório de execução.
- O comportamento real do timeout e da repetição continua sem validação.
- Em uma mudança concreta, a liberação permaneceria bloqueada até essas evidências existirem.

**Veredito: PASS**

## Parecer geral

**PASS — 4 de 4 casos aprovados.**

A skill ajustada conduz às verificações exigidas e agora também determina classificação explícita de severidade e separação entre evidência observada, validação executada, resultado comprovado e itens não validados.

Este resultado aprova o comportamento da skill diante dos casos sintéticos. Ele não constitui aprovação de commits reais, pois os casos não fornecem diffs, fontes afetados, checkout ACBr acessível ou evidências de compilação e execução. Nenhum arquivo foi alterado e nenhuma operação externa foi realizada.