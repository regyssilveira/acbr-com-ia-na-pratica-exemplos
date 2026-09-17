# Suíte de skills ACBr

Estas skills apoiam tarefas com componentes ACBr usados diretamente em projetos Delphi. ACBrLib e ACBrMonitorPLUS não fazem parte do escopo.

## Escolha pela tarefa

| Necessidade | Skill |
|---|---|
| pedido misto ou ainda pouco definido | `acbr-component-work` |
| compreender um projeto recebido | `acbr-project-onboarding` |
| iniciar ou ampliar uma integração | `acbr-integration-start` |
| investigar erro, rejeição ou divergência | `acbr-problem-diagnosis` |
| revisar uma alteração antes de aceitá-la | `acbr-change-review` |
| conferir instalação, packages, paths e DCUs | `acbr-environment-setup` |
| atualizar a revisão ACBr | `acbr-version-update` |
| resolver erro de compilação ou linking | `acbr-build-troubleshooting` |
| investigar exceção, timeout, travamento ou encoding | `acbr-runtime-diagnosis` |
| criar testes, fixtures e dublês locais | `acbr-test-design` |
| revisar configuração e precedência de valores | `acbr-configuration-review` |
| tratar sucesso, rejeição, timeout e estado incerto | `acbr-response-handling` |
| coletar logs e evidências sanitizadas | `acbr-logging-evidence` |
| investigar lentidão ou bloqueio da interface | `acbr-performance-review` |
| revisar segredos, dados e efeitos externos | `acbr-security-review` |
| preparar relato reproduzível para suporte | `acbr-support-request` |

Instale somente a pasta da skill necessária. Use a entrada geral quando a tarefa combinar descoberta, diagnóstico e revisão ou quando ainda não houver evidência suficiente para classificá-la. Para procurar por linguagem cotidiana, use `..\scripts\find-skill.ps1 -Query 'descreva seu problema'`.

## Escolha pela família

| Domínio | Skill e cobertura inicial |
|---|---|
| documentos fiscais eletrônicos | `acbr-dfe`: NFe/NFCe, CTe, MDFe e NFSe |
| cobranças e pagamentos | `acbr-payments`: Boleto, PIXCD e TEF |
| dispositivos fiscais | `acbr-fiscal-devices`: SAT |
| obrigações e arquivos textuais | `acbr-text-obligations`: SPED e TXT |
| impressão | `acbr-printing`: PosPrinter e apoio a relatórios |
| comunicação | `acbr-communication`: Serial e TCP |

Combine uma skill de tarefa com uma família. Exemplo: para investigar timeout do PIX, use o procedimento de `acbr-runtime-diagnosis` e a referência PIXCD de `acbr-payments`. O arquivo [catalog.json](catalog.json) é o inventário legível por máquina e registra o estado de cada pacote.

Para começar por um problema concreto, consulte as [receitas de uso diário](recipes.md). Elas fornecem pedidos adaptáveis e explicam qual resultado deve ser exigido da IA.

## Uso e adaptação

Os pacotes seguem o formato de skills do Codex: cada pasta possui um `SKILL.md` e pode incluir referências ou scripts. Copie a pasta escolhida para o diretório de skills reconhecido pela instalação do Codex.

O instalador assistido mostra as ações sem alterar nada por padrão:

```powershell
.\scripts\install-skills.ps1 -Skill 'acbr-dfe'
.\scripts\install-skills.ps1 -Skill 'acbr-dfe' -Apply
```

Antes de usar `-Apply`, confira o destino exibido. Uma pasta existente recebe uma cópia de segurança datada.

O procedimento não depende de um modelo específico. Outras ferramentas podem reutilizar as instruções, referências, scripts e casos de avaliação, mas a descoberta automática de `SKILL.md` deve ser considerada não verificada até ser confirmada na documentação da ferramenta.

Consulte [compatibility.md](compatibility.md) antes de declarar suporte a outro agente.

## Expansão planejada

A coleção é ampliada em duas direções complementares: tarefas recorrentes e famílias de componentes. O desenho evita duplicar o mesmo procedimento em uma skill para cada componente.

Consulte o [roteiro de expansão](../docs/skill-expansion-roadmap.md) para ver prioridades, referências previstas, recursos compartilhados e critérios de pronto. Itens do roteiro ainda não devem ser apresentados como skills publicadas.

## Limites comuns

- confirme Delphi, revisão ACBr, plataforma e paths reais;
- não invente símbolos ausentes nos fontes observados;
- preserve pares PAS/DFM;
- não exponha certificado, senha, XML ou dados reais;
- não decida tributação;
- não execute efeito fiscal externo sem autorização explícita e ambiente conferido;
- diferencie planejado, implementado, compilado, executado e revisado.

## Validação

```powershell
.\scripts\validate-skills.ps1
```

O comando valida estrutura e referências. Os casos em `references/eval-cases.md` avaliam comportamento e devem ser repetidos após mudanças que alterem instruções ou limites.
