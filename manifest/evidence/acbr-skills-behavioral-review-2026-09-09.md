# Evidência — avaliação comportamental das skills ACBr

Data: 2026-09-09

Versão candidata: `pilot-v0.4.0`

## Método

Quatro sessões independentes do Codex receberam somente a skill especializada, seus quatro casos e o repositório em sandbox de leitura. Cada sessão precisou produzir resposta ao usuário, fontes ou ações, critérios atendidos, lacunas e veredito.

Uma primeira rodada aprovou os 16 casos, mas sugeriu salvaguardas mais explícitas. As instruções foram ajustadas para registrar evidências, proteger buscas de segredos, comprovar paths/DCUs, separar camadas, estruturar hipóteses e classificar achados. Na reavaliação, o caso de configuração sensível encontrou uma lacuna: faltava exigir saneamento do segredo versionado. A regra foi corrigida e o caso foi repetido.

## Resultado final

| Skill | Casos | Resultado |
|---|---:|---|
| `acbr-project-onboarding` | 4 | 4 PASS |
| `acbr-integration-start` | 4 | 4 PASS |
| `acbr-problem-diagnosis` | 4 | 4 PASS |
| `acbr-change-review` | 4 | 4 PASS |

Os relatórios integrais estão em `manifest/evidence/evaluations/`.

## Limites

Os casos comprovam decisões e salvaguardas diante dos cenários avaliados. Não comprovam compatibilidade universal com versões do Delphi, revisões ACBr, ferramentas de agentes ou serviços fiscais. Nenhuma operação externa foi executada.
