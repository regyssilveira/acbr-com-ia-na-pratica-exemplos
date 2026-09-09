# Compatibilidade da suíte

Esta matriz distingue uso comprovado de material apenas reaproveitável. “Adaptável” não significa instalação automática.

| Recurso | Codex | Outros agentes |
|---|---|---|
| `SKILL.md` | formato diretamente utilizável | adaptável; descoberta não verificada |
| referências Markdown | reutilizáveis | reutilizáveis |
| scripts PowerShell | executáveis no ambiente validado | executáveis quando PowerShell e paths forem compatíveis |
| casos de avaliação | reutilizáveis | reutilizáveis |
| `AGENTS.md` do projeto | diretamente utilizável | depende da ferramenta |

## Linha de base comprovada

- Codex com leitura de `SKILL.md`;
- PowerShell no Windows;
- RAD Studio 13 Florence, compilador Delphi 37.0;
- build Win32 do projeto Caixa Ágil;
- checkout ACBr externo ao repositório.

Kai, Claude Code, GitHub Copilot, Gemini CLI e outros agentes são cenários de adaptação. Não declare suporte direto sem executar instalação, seleção da skill, acesso aos recursos e casos comportamentais na versão correspondente.
