# Roteiro de expansão das skills ACBr

Este roteiro amplia a suíte pública de skills do livro sem transformar cada componente ou tarefa em um pacote isolado e repetitivo. O escopo continua restrito aos componentes ACBr usados diretamente em projetos Delphi; ACBrLib e ACBrMonitorPLUS permanecem fora desta edição.

## Princípio de organização

A coleção deve funcionar como uma matriz de três camadas:

1. **Skills de tarefa** orientam o trabalho que o desenvolvedor quer realizar.
2. **Skills de família** preservam diferenças técnicas entre grupos de componentes.
3. **Referências por componente** registram fontes, demos, símbolos de entrada, invariantes e gates específicos sem duplicar todo o fluxo.

Uma solicitação comum combina uma skill de tarefa com uma referência de componente. Por exemplo: diagnosticar uma rejeição de CT-e usa `acbr-problem-diagnosis`, a família `acbr-dfe` e a referência `cte.md`.

Criar uma skill independente por componente só se justifica quando o componente possui fluxo, riscos e validações suficientemente diferentes para exigir instruções próprias.

## Camada 1 — tarefas recorrentes

As cinco skills originais cobriam descoberta, início, diagnóstico e revisão. A expansão abaixo acrescenta os fluxos diários que faltavam.

| Prioridade | Pacote | Estado | Resultado esperado |
|---|---|---|---|
| P0 | `acbr-environment-setup` | RV | verificar instalação, packages, paths, DCUs, plataforma e revisão efetivamente compilada |
| P0 | `acbr-version-update` | RV | comparar revisões, localizar quebra de API, planejar migração e executar gates sem atualizar silenciosamente |
| P0 | `acbr-build-troubleshooting` | RV | diagnosticar unit ausente, DCU incompatível, path duplicado, package e conflito entre versões |
| P0 | `acbr-runtime-diagnosis` | RV | investigar AV, timeout, travamento, vazamento, encoding e divergência entre IDE e executável |
| P0 | `acbr-test-design` | RV | criar testes locais, fixtures fictícias, dublês e cenários sem efeito fiscal externo |
| P1 | `acbr-configuration-review` | RV | revisar propriedades, arquivos INI, providers, schemas, certificados e separação por ambiente |
| P1 | `acbr-response-handling` | RV | modelar autorização, rejeição, duplicidade, timeout, consulta e resultado incerto sem reenvio cego |
| P1 | `acbr-logging-evidence` | RV | produzir logs mínimos, reproduções e evidências anonimizadas para diagnóstico ou fórum |
| P1 | `acbr-performance-review` | RV | localizar gargalos, bloqueio de UI, processamento em lote e uso indevido de recursos |
| P1 | `acbr-security-review` | RV | detectar segredo, dado fiscal real, XML sensível, log excessivo e operação externa não autorizada |
| P1 | `acbr-support-request` | RV | transformar sintomas e evidências em relato curto, reproduzível e seguro para a comunidade |

As skills `acbr-runtime-diagnosis` e `acbr-build-troubleshooting` devem complementar, não duplicar, `acbr-problem-diagnosis`: a entrada geral classifica o problema e encaminha para o procedimento específico.

## Camada 2 — famílias de componentes

| Prioridade | Família | Estado | Componentes e domínios iniciais | Por que merece tratamento próprio |
|---|---|---|---|---|
| P0 | `acbr-dfe` | RV | NFe/NFCe, CTe, MDFe, NFSe | documentos, schemas, assinatura, webservices, eventos, retornos e impressão |
| P0 | `acbr-payments` | RV | Boleto, PIXCD, TEFD/TEFAPI | credenciais, providers, transações financeiras, conciliação e estados incertos |
| P0 | `acbr-fiscal-devices` | RV | SAT | comunicação com hardware, sessão, ativação, códigos de retorno e ambiente físico |
| P1 | `acbr-text-obligations` | RV | SPED, Sintegra e demais geradores TXT aplicáveis | registros hierárquicos, validação estrutural, competência e grande volume de dados |
| P1 | `acbr-printing` | RV | PosPrinter e relatórios DFe | dispositivo, code page, comandos, spool, PDF e vínculo com documento |
| P1 | `acbr-communication` | RV | Serial e TCP | portas, protocolo, timeout, encoding e recursos externos |
| P2 | `acbr-commerce-integrations` | PL | OpenDelivery, Integrador e integrações comerciais presentes na revisão | contratos externos, autenticação, disponibilidade e evolução de APIs |
| P2 | `acbr-baas` | PL | componentes BaaS presentes na revisão | dependência de serviço, credenciais e diferenças em relação ao componente local |

Os nomes e a inclusão de componentes devem ser confirmados na revisão ACBr declarada. A existência de uma pasta ou package não prova que um fluxo esteja pronto, suportado ou validado nesta coleção.

## Camada 3 — referências por componente

Cada família deve carregar apenas a referência necessária à tarefa. O primeiro catálogo recomendado é:

- `dfe/nfe-nfce.md`, `dfe/cte.md`, `dfe/mdfe.md`, `dfe/nfse.md`;
- `payments/boleto.md`, `payments/pixcd.md`, `payments/tef.md`;
- `fiscal-devices/sat.md`;
- `text-obligations/sped.md`, `text-obligations/txt.md`;
- `printing/posprinter.md`;
- `communication/serial.md`, `communication/tcp.md`.

Uma referência de componente deve conter somente informação que muda decisões:

- units, classes e demos a localizar na revisão instalada;
- pré-condições e propriedades que precisam ser conferidas;
- fluxos e estados relevantes;
- efeitos externos possíveis e limites de segurança;
- erros recorrentes formulados como hipóteses, não como diagnóstico automático;
- gates locais e evidências mínimas;
- lacunas que exigem regra fiscal, credencial, equipamento ou validação humana.

Não copiar manuais, tabelas fiscais ou APIs inteiras. Símbolos devem ser verificados nos fontes da revisão-alvo antes de serem apresentados como disponíveis.

## Expansões além das skills

Para tornar a coleção realmente útil no dia a dia, o repositório também deve ganhar:

### Catálogo legível por máquina

Um manifesto deve relacionar tarefa, família, componente, risco, referências, scripts e estado de evidência. Isso permite validar cobertura, gerar índices e evitar duas skills concorrentes para o mesmo pedido.

### Avaliações comportamentais

Cada skill precisa de casos de sucesso, ambiguidade e recusa segura. Os casos devem verificar decisões observáveis: uso da revisão correta, separação entre fato e hipótese, preservação PAS/DFM, ausência de segredo e proibição de efeito externo não autorizado.

### Fixtures e reproduções mínimas

Adicionar massas fictícias e pequenos projetos reproduzíveis para build, timeout, rejeição simulada, encoding, path duplicado e resultado incerto. A avaliação não deve depender de certificado, contribuinte ou serviço real.

### Scripts determinísticos

Priorizar ferramentas somente leitura para:

- inventariar packages, units, DCUs e paths duplicados;
- localizar classe, propriedade e demo na mesma revisão;
- comparar símbolos entre duas revisões;
- verificar pares PAS/DFM e componentes persistidos;
- detectar textos corrompidos e codificações inconsistentes;
- sanitizar uma cópia de logs antes de compartilhamento;
- resumir resultados de build e testes sem esconder warnings.

Scripts que alterem configuração, instalem packages, movimentem certificados ou chamem serviços externos não devem ser automáticos por padrão.

### Receitas curtas

Criar cartões de uso combinando tarefa e componente, por exemplo:

- iniciar NFC-e em projeto existente;
- investigar rejeição sem reenviar;
- atualizar ACBr e localizar quebra de enumeração;
- descobrir por que o componente existe no DFM mas não compila;
- diagnosticar timeout de TEF ou PIX sem duplicar transação;
- validar geração SPED com massa fictícia;
- investigar caracteres corrompidos entre fonte, DFM, terminal e executável.

As receitas não substituem as skills; mostram ao leitor como formular a solicitação e quais evidências esperar.

## Sequência de entrega

### Marco A — fundação

1. criar o manifesto do catálogo e seu validador;
2. definir o contrato das referências por componente;
3. ampliar a árvore de decisão da skill geral;
4. acrescentar detecção de codificação ao gate do repositório.

### Marco B — núcleo de maior uso

1. publicar `acbr-environment-setup`, `acbr-version-update`, `acbr-build-troubleshooting`, `acbr-runtime-diagnosis` e `acbr-test-design`;
2. publicar as famílias `acbr-dfe` e `acbr-payments`;
3. cobrir NFe/NFCe, CTe, MDFe, NFSe, Boleto, PIX e TEF;
4. executar validação estrutural e avaliações comportamentais independentes.

### Marco C — cobertura operacional

Adicionar SAT, SPED/TXT, impressão, Serial/TCP e as tarefas de configuração, logging, segurança e suporte.

### Marco D — cauda longa

Priorizar componentes restantes a partir de pedidos reais, disponibilidade de demos e capacidade de criar avaliações reproduzíveis. Não declarar “todos os componentes” enquanto houver apenas inventário nominal.

## Critério de pronto

Uma nova skill ou referência só pode ser apresentada como publicada quando:

- usa fontes e demos da revisão ACBr registrada;
- possui descrição discriminante e roteamento inequívoco;
- não duplica regras já mantidas por outra skill;
- tem ao menos um caso normal, um caso ambíguo e um limite de segurança avaliado;
- passa validação estrutural e de links;
- registra o que foi apenas documentado, testado localmente ou efetivamente executado;
- não exige ACBrLib, ACBrMonitorPLUS, dado real ou operação fiscal externa.

## Relação com o livro

O livro deve explicar a matriz, ensinar a escolher tarefa e componente e apresentar duas ou três receitas completas. O catálogo integral, as skills e as avaliações ficam no repositório público para evoluir sem aumentar significativamente o número de páginas.

O resultado da revisão de utilidade desta entrega está em [skills-usefulness-audit-2026-09-17.md](skills-usefulness-audit-2026-09-17.md).
