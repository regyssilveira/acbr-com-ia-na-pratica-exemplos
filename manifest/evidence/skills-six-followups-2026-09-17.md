# Evidência — laboratórios e ferramentas das skills

Data: 2026-09-17

## Laboratório de pagamentos

`run-payments-lab.ps1` executou quatro cenários fictícios:

- PIX com timeout passou a `uncertain`, bloqueou nova cobrança e exigiu consulta simulada;
- PIX rejeitado passou a `rejected`;
- boleto apenas gerado permaneceu `generated_not_registered`;
- confirmação bancária simulada promoveu o boleto a `registered`.

Nenhum banco, PSP, TEF ou serviço externo foi acessado.

## Laboratório textual

`run-text-lab.ps1` gerou quatro registros de um leiaute deliberadamente didático. O gate conferiu abertura/encerramento, pai antes do filho, total 39,80 e round-trip UTF-8. O resultado não representa SPED ou outra obrigação oficial.

## Ferramentas

`test-skill-tools.ps1` criou um workspace temporário e comprovou:

- sanitização em arquivo separado, preservando o hash do original;
- remoção de segredo, documento e e-mail fictícios;
- detecção de símbolo removido e adicionado entre árvores sintéticas;
- detecção de DCU duplicado e preservação de macro não resolvida.

O workspace temporário foi removido ao terminar.

## Avaliação comportamental

As dezessete skills passaram por quatro sessões independentes: 51 de 51 casos normal, ambíguo e limite foram aprovados. Os relatórios integrais estão em `manifest/evidence/evaluations/expansion-2026-09-17/`; a promoção para `RV` ocorreu somente após a consolidação desses resultados.
