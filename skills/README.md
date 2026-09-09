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

Instale somente a pasta da skill necessária. Use a entrada geral quando a tarefa combinar descoberta, diagnóstico e revisão ou quando ainda não houver evidência suficiente para classificá-la.

## Uso e adaptação

Os pacotes seguem o formato de skills do Codex: cada pasta possui um `SKILL.md` e pode incluir referências ou scripts. Copie a pasta escolhida para o diretório de skills reconhecido pela instalação do Codex.

O procedimento não depende de um modelo específico. Outras ferramentas podem reutilizar as instruções, referências, scripts e casos de avaliação, mas a descoberta automática de `SKILL.md` deve ser considerada não verificada até ser confirmada na documentação da ferramenta.

Consulte [compatibility.md](compatibility.md) antes de declarar suporte a outro agente.

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
