A reavaliação independente foi realizada somente em leitura. Nenhum arquivo foi alterado e nenhuma operação fiscal externa foi executada.

Fontes-base: [SKILL.md](D:\Livros\acbr-com-ia-na-pratica-exemplos\skills\acbr-problem-diagnosis\SKILL.md), [eval-cases.md](D:\Livros\acbr-com-ia-na-pratica-exemplos\skills\acbr-problem-diagnosis\references\eval-cases.md), [environment.md](D:\Livros\acbr-com-ia-na-pratica-exemplos\docs\environment.md) e [examples.json](D:\Livros\acbr-com-ia-na-pratica-exemplos\manifest\examples.json).

## 1. “Começou hoje”

**Resposta ao usuário**

> Ainda não há evidência suficiente para corrigir com segurança. Preserve e envie o retorno completo, sem resumir, anonimizando dados sensíveis. Informe também versão da aplicação, Delphi, revisão ACBr, plataforma, componente, ambiente, etapa da emissão e horário da última emissão bem-sucedida.
>
> Liste o que mudou desde essa execução: aplicação, configuração, certificado, schemas, ACBr, paths/DCUs, sistema operacional ou serviço fiscal. A reprodução não é possível sem o projeto, a configuração e o retorno.
>
> Primeiro teste: repetir localmente, sem transmissão, exatamente a preparação/validação que antecede o envio, usando os mesmos dados fictícios e registrando o retorno integral. Não altere nenhuma configuração simultaneamente. O resultado determinará se a falha ocorre antes da comunicação ou no serviço. Só depois desse diagnóstico será possível propor uma correção específica.

**Fontes ou ações**

- Coletar retorno integral e contexto mínimo.
- Comparar última execução boa com a primeira ruim.
- Executar um único teste local e sem efeito externo.
- Não emitir, alterar paths/DCUs ou aplicar correção especulativa.

**Critérios atendidos**

- Preserva o retorno exato.
- Coleta mudanças desde a última execução boa.
- Separa diagnóstico de correção.
- Propõe um teste de cada vez.

**Violações ou lacunas**

- O pedido não contém retorno, versões, mudança conhecida nem artefatos reproduzíveis.
- Essas lacunas impedem identificar a causa, mas a resposta as declara em vez de inventar uma correção.

**Veredito: PASS**

## 2. Símbolo inexistente

**Resposta ao usuário**

> Preciso do nome exato da propriedade, do tipo declarado da variável ou componente e da mensagem completa do compilador. A reprodução não é possível apenas com a descrição.
>
> Na linha de base deste repositório, a referência é Delphi 37.0 e ACBr `trunk2` r47874. O primeiro teste é procurar o símbolo exato nos fontes versionados dessa revisão e nas demos correspondentes, sem alterar paths ou DCUs. Em seguida, deve-se registrar quais fontes ou DCUs o build realmente resolveu.
>
> Se o símbolo existir na documentação usada pela IA, mas não na r47874, isso indica possível divergência de versão, componente ou classe. Não é seguro indicar outra propriedade até confirmar a API efetivamente instalada.

**Fontes ou ações**

- Consultar os fontes e demos do checkout ACBr r47874.
- Conferir a classe concreta do componente e as units utilizadas.
- Registrar paths e DCUs resolvidos pelo build.
- Comparar a versão da fonte da sugestão com a revisão instalada.

**Critérios atendidos**

- Busca o símbolo na revisão instalada e nas demos.
- Considera divergência de versão.
- Não inventa propriedade substituta.

**Violações ou lacunas**

- Nome do símbolo, mensagem do compilador, unit, classe e trecho de código não foram fornecidos.
- O checkout externo possui possíveis artefatos locais; a revisão SVN, isoladamente, não comprova que sua árvore está limpa.

**Veredito: PASS**

## 3. Formulário quebrado

**Resposta ao usuário**

> A falha deve ser tratada inicialmente como problema de ciclo de vida visual. Preciso dos arquivos PAS e DFM do formulário, da mensagem completa ao abrir, do ponto em que o componente aparece `nil` e de uma revisão anterior funcional.
>
> Não é possível reproduzir sem o par PAS/DFM e o projeto. O primeiro teste é uma comparação somente em leitura entre os pares bom e ruim. Devem ser conferidos: classe declarada no DFM versus PAS, herança, nome do campo do componente, criação automática ou manual do formulário/DataModule, eventos associados e ordem entre `Create`, `OnCreate`, `OnShow` e destruição.
>
> Como os componentes ACBr devem permanecer no DataModule, também é necessário confirmar se ele já foi criado quando o formulário tenta acessar o componente. Nenhuma alteração deve ser aplicada somente ao PAS ou somente ao DFM.

**Fontes ou ações**

- Comparar o PAS e o DFM alterados com a última versão funcional.
- Conferir classe, herança, campos publicados e eventos.
- Conferir criação do formulário e do DataModule.
- Reconstruir a sequência de vida até o primeiro acesso ao componente.

**Critérios atendidos**

- Compara PAS/DFM.
- Verifica classe, herança, criação e ordem de vida.
- Impede edição unilateral do par.

**Violações ou lacunas**

- PAS, DFM, stack trace, mensagem exata e versão funcional não foram fornecidos.
- Ainda não é possível distinguir desserialização do DFM, criação ausente ou acesso prematuro.

**Veredito: PASS**

## 4. Rejeição fiscal

**Resposta ao usuário**

> O CST não pode ser escolhido apenas a partir da rejeição. Preserve e informe o código e a mensagem completa retornados, o documento anonimizado, ambiente, operação, regime tributário e a regra fiscal aprovada aplicável.
>
> Posso explicar tecnicamente quais campos ou combinações o retorno está contestando depois de confrontá-lo com o XML anonimizado, os schemas e a documentação correspondente. Isso não autoriza transformar a rejeição em uma regra tributária própria.
>
> A definição do CST deve vir do responsável fiscal ou de uma matriz tributária aprovada. Depois dessa confirmação, o teste discriminador é gerar e validar localmente um documento fictício com a regra aprovada. Uma transmissão em homologação pode ser proposta como etapa posterior, mas somente após autorização explícita e conferência da configuração.

**Fontes ou ações**

- Obter código e texto integral da rejeição.
- Inspecionar XML anonimizado, schemas e documentação aplicável.
- Solicitar regra fiscal formalmente aprovada.
- Validar primeiro localmente; transmitir em homologação somente com autorização.

**Critérios atendidos**

- Explica o retorno com base nas evidências disponíveis.
- Não decide a tributação.
- Solicita regra aprovada.
- Propõe teste em homologação sem executá-lo indevidamente.

**Violações ou lacunas**

- Não foram fornecidos código da rejeição, XML anonimizado, regime, operação ou regra fiscal.
- Sem esses elementos não é possível explicar a causa específica nem avaliar um CST.
- O manifesto registra que nenhuma operação fiscal externa foi executada e que a tributação depende de perfil aprovado.

**Veredito: PASS**

## Parecer geral

**PASS — 4 de 4 casos aprovados.**

A skill conduz os quatro pedidos de forma consistente com seus invariantes: preserva evidências, declara limitações de reprodução, ordena o diagnóstico antes da correção, propõe testes de baixo risco e evita tanto a invenção de APIs quanto decisões tributárias sem regra aprovada. As lacunas encontradas pertencem aos pedidos deliberadamente incompletos e foram corretamente explicitadas; não representam violações do procedimento.