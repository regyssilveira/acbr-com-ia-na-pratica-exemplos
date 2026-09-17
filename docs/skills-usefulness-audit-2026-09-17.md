# Auditoria de utilidade das skills — 2026-09-17

## Pergunta da auditoria

A coleção ajuda um desenvolvedor no trabalho diário ou apenas descreve boas intenções?

## Evidência observada

| Dimensão | Evidência atual | Avaliação |
|---|---|---|
| descoberta | router, tabela por tarefa, tabela por família, vinte receitas e fluxo guiado | forte |
| tarefas diárias | onboarding, início, ambiente, atualização, build, execução, testes, configuração, respostas, logs, desempenho, segurança, suporte e revisão | forte |
| componentes | dezesseis referências em seis famílias | boa para o núcleo priorizado |
| vínculo com ACBr real | fontes, demos e símbolo de entrada conferidos no checkout registrado | forte |
| segurança | limites explícitos para fiscal, financeiro, segredo, hardware e efeito externo | forte |
| reprodução | Caixa Ágil, pagamentos e TXT; dez testes e gates determinísticos | boa, com três domínios locais |
| qualidade das skills | validação estrutural, catálogo, links, casos normal/ambíguo/limite nas novas skills | boa |
| comportamento independente | quatro sessões, 51/51 casos PASS e relatórios versionados | forte nos cenários avaliados |
| distribuição | pastas copiáveis, perfis, simulação, backup e consulta de atualização | forte |

## Simulações de uso cobertas

A coleção possui um caminho explícito para os seguintes pedidos comuns:

- “peguei este projeto e não sei por onde começar”;
- “a unit/propriedade não existe”;
- “atualizei o ACBr e parou de compilar”;
- “funciona na IDE e falha no executável”;
- “o texto ou a impressão está com caracteres errados”;
- “recebi rejeição, exceção ou timeout”;
- “não sei se posso repetir a operação”;
- “preciso iniciar NFe/NFCe, CTe, MDFe ou NFSe”;
- “preciso configurar Boleto, PIX ou TEF”;
- “o SAT não comunica”;
- “o SPED/TXT não passa no validador”;
- “a Serial/TCP está incompleta ou cai”;
- “quero criar teste sem acessar serviço real”;
- “preciso compartilhar um diagnóstico sem expor dados”.

Para cada situação há uma skill de tarefa, uma família quando aplicável, limites de segurança e uma receita inicial.

## Melhorias ainda recomendadas

### P0 — antes de declarar a expansão revisada

1. **Concluído:** quatro sessões independentes avaliaram 51 casos sem compartilhar resultados.
2. **Concluído:** relatórios foram versionados e as dezessete skills aprovadas passaram para `RV`.
3. **Concluído:** laboratórios de pagamentos e TXT executam sem efeito externo e registram limites explícitos.

### P1 — aumenta muito a utilidade cotidiana

1. **Concluído:** sanitizador assistido gera cópia e relatório sem sobrescrever o original.
2. **Concluído:** comparador de símbolos trabalha sobre dois checkouts em modo somente leitura.
3. **Concluído:** inventário de `.dproj` lista paths literais, macros e DCUs duplicados sem alterar a IDE.
4. **Concluído:** receitas para certificado/provider SSL, NFSe por município/provider, DANFE/relatórios e contingência.
5. **Concluído:** instalação por perfil, simulação, backup e consulta de atualização.

### P2 — ampliar componentes por demanda comprovada

- balança, CEP, IBGE, e-mail e consultas TCP;
- OpenDelivery e Integrador;
- PagFor, débito automático, PicPay e outros providers de pagamento;
- BaaS;
- outros DF-e e obrigações presentes na revisão.

Não há telemetria pública suficiente neste repositório para ordenar a cauda longa por uso. A prioridade deve vir de dúvidas recorrentes do fórum, feedback dos leitores e capacidade de criar caso reproduzível seguro.

## Conclusão

A coleção deixou de ser apenas uma skill geral e passou a cobrir o ciclo diário completo: descobrir, preparar, implementar, diagnosticar, testar, revisar e pedir ajuda. O principal limite restante não é quantidade de texto, mas confiança comportamental e variedade de laboratórios executáveis. Acrescentar muitas referências nominais antes desses dois pontos aumentaria a aparência de cobertura sem aumentar a utilidade na mesma proporção.
