# Receitas de uso diário

Estas receitas combinam uma tarefa e uma família. Substitua os campos entre colchetes, forneça apenas arquivos necessários e nunca inclua certificado, senha, token, XML ou dado real.

## Conhecer um projeto recebido

> Use `acbr-project-onboarding`. Examine somente `[pasta do projeto]`. Identifique versão do Delphi, plataforma, componentes ACBr, pares PAS/DFM, configuração, pontos de entrada e riscos. Cite os arquivos usados, separe fatos de lacunas e não altere nada.

**Espere receber:** mapa curto do projeto, componentes comprovados, fluxo principal e perguntas que realmente impedem o próximo passo.

## Resolver unit ou símbolo não encontrado

> Use `acbr-build-troubleshooting`. O build `[comando/configuração]` falha primeiro em `[erro textual]`. Compare os paths do projeto com o checkout `[caminho e revisão]`, localize a unit/símbolo nos fontes e demos e indique o menor teste que distingue path incorreto de quebra de API. Não copie DCUs entre versões.

**Espere receber:** origem provável ordenada por evidência, path vencedor e comando de verificação.

## Atualizar o ACBr com controle

> Use `acbr-version-update`. Compare a revisão `[anterior]` com `[nova]` para o projeto `[pasta]`. Registre a linha de base, encontre símbolos usados que mudaram, classifique impactos em package, API, comportamento e schema e proponha migração incremental com rollback. Não atualize o checkout ainda.

**Espere receber:** inventário de impactos e gates, não uma promessa genérica de compatibilidade.

## Começar NFe ou NFCe

> Use `acbr-integration-start` com `acbr-dfe`, referência `nfe-nfce`. No projeto `[pasta]`, quero iniciar `[NFe 55/NFCe 65]` em homologação. Confirme a revisão e a demo correspondente, proponha separação entre domínio, mapper, componente e gateway e liste as regras fiscais que precisam vir de fonte aprovada. Não transmita documentos.

**Espere receber:** arquitetura mínima, fontes verificadas, lacunas fiscais e primeiro teste local.

## Diagnosticar rejeição de DF-e

> Use `acbr-problem-diagnosis` com `acbr-dfe`, referência `[nfe-nfce/cte/mdfe/nfse]`. Temos código `[código]`, mensagem `[mensagem]`, etapa `[etapa]` e trecho sanitizado `[arquivo]`. Separe schema, preenchimento, serviço e transporte; produza hipóteses ordenadas e um teste de baixo risco para cada uma. Não invente regra fiscal.

**Espere receber:** hipótese ligada a evidência e próximo teste, não apenas a repetição da mensagem.

## Tratar timeout sem duplicar operação

> Use `acbr-runtime-diagnosis` com a família `[acbr-dfe/acbr-payments/acbr-communication]`. A operação `[nome]` recebeu timeout depois de `[última evidência]` e possui identificador `[id fictício/sanitizado]`. Modele o resultado como incerto, localize a consulta disponível na revisão e impeça repetição até resolver o estado.

**Espere receber:** estratégia de consulta, idempotência e evidência necessária antes de tentar novamente.

## Configurar Boleto

> Use `acbr-integration-start` com `acbr-payments`, referência `boleto`. Banco `[banco]`, carteira `[informada pelo banco]`, modalidade `[registrada/não registrada]`, ambiente `[teste]`. Localize classe e demo na revisão, separe geração, impressão, remessa, registro e retorno e liste campos que não podem ser inferidos.

**Espere receber:** checklist contratual e técnico; PDF não deve ser tratado como registro comprovado.

## Diagnosticar PIX ou TEF pendente

> Use `acbr-runtime-diagnosis` com `acbr-payments`, referência `[pixcd/tef]`. A transação ficou `[estado]` após `[evento]`. Preserve identificadores sanitizados, reconstrua a sequência e indique consulta, confirmação ou desfazimento previsto pelo provider/solução. Não crie uma segunda cobrança ou venda.

**Espere receber:** linha do tempo, estado conhecido e ação segura seguinte.

## Investigar SAT

> Use `acbr-runtime-diagnosis` com `acbr-fiscal-devices`, referência `sat`. Modelo `[modelo]`, arquitetura `[Win32/Win64]`, biblioteca `[nome sem segredo]`, comando `[consulta de baixo risco]` e retorno `[código/mensagem]`. Separe carregamento, comunicação, sessão e protocolo. Não ative nem venda.

**Espere receber:** camada que falhou e teste seguro para confirmá-la.

## Validar SPED ou TXT

> Use `acbr-test-design` com `acbr-text-obligations`, referência `[sped/txt]`. Obrigação `[nome exato]`, leiaute `[versão]`, competência `[fictícia]` e erro do validador `[mensagem]`. Crie uma fixture mínima, confira hierarquia, totalizações e encoding e declare o que depende de revisão fiscal.

**Espere receber:** caso reproduzível pequeno e invariantes, não dados inventados para silenciar o validador.

## Corrigir acentos na impressão

> Use `acbr-runtime-diagnosis` com `acbr-printing`, referência `posprinter`. O texto `[fictício]` está correto em `[fonte/tela]` e incorreto em `[impressora]`. Confira bytes, conversão, modelo e página de código em etapas, começando por saída redirecionada. Não acione corte ou gaveta.

**Espere receber:** localização da primeira transformação incorreta e teste isolado.

## Preparar um pedido de ajuda

> Use `acbr-problem-diagnosis`. Converta `[notas e logs sanitizados]` em um relato de até oito linhas com ambiente, revisão, componente, objetivo, resultado, primeiro erro, tentativas e pergunta objetiva. Aponte o que ainda falta; não publique nem inclua segredo.

**Espere receber:** relato reproduzível e seguro, pronto para revisão humana.
