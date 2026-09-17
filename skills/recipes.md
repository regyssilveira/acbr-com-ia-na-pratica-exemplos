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

## Diagnosticar certificado ou provider SSL

> Use `acbr-configuration-review` e `acbr-runtime-diagnosis`. Ambiente `[homologação]`, Delphi `[versão/plataforma]`, ACBr `[revisão]`, provider SSL `[nome]` e erro sanitizado `[mensagem]`. Confira carregamento, validade, chave privada, cadeia, biblioteca e configuração sem abrir nem copiar o certificado. Comece pelo laboratório fictício e não transmita documento.

**Espere receber:** camada provável, evidência que falta e teste local que não expõe segredo.

## Investigar NFSe por município e provider

> Use `acbr-problem-diagnosis` com `acbr-dfe`, referência `nfse`. Município `[IBGE]`, provider `[confirmado ou não verificado]`, ambiente `[homologação]`, operação `[gerar/enviar/consultar]` e primeiro retorno sanitizado `[mensagem]`. Localize configuração e demo na revisão; não presuma que outro município possui o mesmo fluxo.

**Espere receber:** identificação do provider, etapa que falhou e diferenças que precisam ser verificadas.

## Diagnosticar DANFE ou relatório

> Use `acbr-runtime-diagnosis` com `acbr-printing`. Documento fictício `[tipo]`, engine `[Fortes/FastReport/FPDF/outra]`, destino `[preview/PDF/impressora]` e fato observado `[descrição]`. Separe dados do documento, montagem do relatório, fonte, margem, spool e dispositivo. Não use XML real.

**Espere receber:** primeira camada divergente e reprodução visual mínima.

## Planejar contingência

> Use `acbr-response-handling` com `acbr-dfe`. Documento `[tipo]`, modo normal `[estado]`, contingência pretendida `[modo]` e evidência `[retorno/indisponibilidade]`. Mapeie pré-condições, estados persistidos, reconciliação e critérios de saída; marque decisões fiscais e operacionais que precisam de aprovação. Não ative contingência nem transmita.

**Espere receber:** máquina de estados e checklist de autorização, sem decisão fiscal automática.

## Componente no DFM, mas ausente no build

> Use `acbr-build-troubleshooting`. Analise o par `[PAS/DFM]`, o primeiro erro do build e os paths efetivos. Execute `check-pas-dfm.ps1` em modo somente leitura e confira classe registrada, package e DCU da plataforma. Não remova o objeto do DFM para silenciar o erro.

**Espere receber:** divergência comprovada entre persistência, declaração ou package.

## IDE compila, linha de comando não

> Use `acbr-environment-setup` e `acbr-build-troubleshooting`. Compare configuração, plataforma, macros e paths da IDE com o comando `[comando]`. Resuma os dois logs com `summarize-delphi-build.ps1` e identifique a primeira diferença de ambiente, sem copiar DCUs.

**Espere receber:** variável ou path divergente e comando mínimo de confirmação.

## Consultar CEP sem confundir retorno com cadastro

> Use `acbr-integration-start` com `acbr-communication`, referência `cep`. Provider `[nome]`, entrada `[fictícia]` e revisão `[ACBr]`. Modele timeout, ausência, múltiplos resultados e normalização; não grave automaticamente o retorno como endereço confirmado.

**Espere receber:** contrato de entrada/saída, tratamento dos estados e primeiro teste local.

## Diagnosticar e-mail ou balança

> Use `acbr-runtime-diagnosis` com `acbr-communication`, referência `[mail/balanca]`. Para e-mail, informe etapa SMTP/TLS e erro sem credencial; para balança, modelo, porta, parâmetros e bytes fictícios/sanitizados. Isole transporte, protocolo e regra sem acionar destinatário ou equipamento de produção.

**Espere receber:** camada que falhou, evidência mínima e teste seguro em laboratório.
