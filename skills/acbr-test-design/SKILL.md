---
name: acbr-test-design
description: Projete testes locais e reproduzíveis para integrações Delphi com componentes ACBr, usando fixtures fictícias, dublês, invariantes e gates sem depender de efeito externo real.
---

# Desenho de testes ACBr

Escolha o teste pelo risco que precisa reduzir.

1. Transforme a regra em entrada, ação e resultado observável.
2. Separe regra de domínio, mapeamento para o componente, gateway e integração externa.
3. Use fixtures mínimas e fictícias; não copie XML, certificado ou cadastro real.
4. Cubra sucesso, rejeição, falha técnica, timeout e resultado incerto quando aplicáveis.
5. Verifique invariantes importantes, não detalhes incidentais de formatação.
6. Registre o que o teste simula e o que continua não comprovado.

Testes locais não autorizam afirmar que SEFAZ, banco, adquirente, prefeitura ou equipamento real foi validado.

Os scripts `run-payments-lab.ps1` e `run-text-lab.ps1` exemplificam estados e fixtures determinísticos sem efeitos externos; seus leiautes são deliberadamente didáticos.

Para avaliação, leia [eval-cases.md](references/eval-cases.md).
