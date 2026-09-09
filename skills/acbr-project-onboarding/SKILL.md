---
name: acbr-project-onboarding
description: Mapeie um projeto Delphi existente que usa componentes ACBr, identificando estrutura, componentes, configuração, fluxos e lacunas antes de alterá-lo. Não use para ACBrLib ou ACBrMonitorPLUS.
---

# Compreensão inicial de projeto ACBr

Produza um mapa verificável do projeto antes de sugerir mudanças. Leia as instruções do repositório e registre a versão do Delphi, a revisão do ACBr, a plataforma e os caminhos efetivamente usados.

## Investigação

1. Localize DPR ou DPROJ, units, formulários, DataModules, packages e arquivos de configuração.
2. Relacione pares PAS/DFM e identifique componentes ACBr pelo tipo declarado, não apenas pelo nome da variável.
3. Siga criação, configuração e uso dos componentes até os serviços e regras de domínio.
4. Diferencie valores de exemplo, configuração local, segredo ausente e decisão fiscal ainda não fornecida.
5. Confira nos fontes da revisão instalada qualquer símbolo necessário para compreender o fluxo.

## Entrega

Apresente:

- linha de base confirmada e dados ainda desconhecidos;
- mapa curto de arquivos, responsabilidades e dependências;
- fluxo principal desde a entrada até o componente ACBr;
- riscos e pontos que precisam de validação humana;
- três próximos passos pequenos, sem modificar arquivos.

Não invente configuração ausente, não exponha dados sensíveis e não trate o primeiro levantamento como autorização para editar o projeto.

Ao alterar esta skill, execute os casos de [eval-cases.md](references/eval-cases.md).
