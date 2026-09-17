# Evidência — sete melhorias de uso e sincronização

Data: 2026-09-17.

Escopo: descoberta e instalação das skills, diagnóstico somente leitura, pacote sanitizado para suporte, laboratórios fictícios de certificado e atualização e verificação da publicação.

Critérios:

- o localizador recomenda uma skill para um problema cotidiano;
- o instalador não altera o destino sem `-Apply` e cria backup ao atualizar;
- o Doctor não altera projeto, IDE nem checkout ACBr;
- o pacote de suporte trabalha com cópias sanitizadas e exige revisão humana;
- os laboratórios não acessam certificado, serviço fiscal ou checkout real;
- o gate público confere a existência da tag e a quantidade de entradas do catálogo.

Resultado: os testes locais são executados por `scripts/test-skill-tools.ps1` e os laboratórios integram `scripts/validate-all.ps1`. A verificação pública deve ser executada após a criação da tag `pilot-v0.6.0`.
