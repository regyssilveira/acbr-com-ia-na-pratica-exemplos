# Evidência — expansão das skills ACBr

Data: 2026-09-17

## Escopo implementado

- catálogo legível por máquina com vinte e duas skills;
- onze novas skills de tarefa: ambiente, atualização, build, execução, testes, configuração, respostas, evidências, desempenho, segurança e suporte;
- seis famílias: DF-e, pagamentos, dispositivos fiscais, obrigações textuais, impressão e comunicação;
- treze referências para NFe/NFCe, CTe, MDFe, NFSe, Boleto, PIXCD, TEF, SAT, SPED, TXT, PosPrinter, Serial e TCP;
- doze receitas de uso diário combinando tarefa e componente;
- gates de catálogo, cobertura do checkout ACBr e codificação textual.

## Evidências executadas

- `validate-skills.ps1`: estrutura e referências locais das vinte e duas skills;
- `validate-skill-catalog.ps1`: IDs, estados, rotas, famílias e componentes;
- `validate-acbr-coverage.ps1`: fontes, demos e símbolos de entrada localizados no checkout ACBr configurado;
- `check-text-encoding.ps1`: UTF-8 estrito, mojibake conhecido e BOM para fontes/scripts não ASCII;
- `validate-all.ps1`: build Win32, dez testes DUnitX, laboratório local, segurança e todos os gates acima.

O executável recompilado foi inspecionado e contém as strings Unicode corretas `Configuração validada`, `Simulação local` e `laboratório`; as variantes corrompidas não foram localizadas.

## Avaliação comportamental independente

Quatro sessões isoladas avaliaram as dezessete novas skills em 51 casos, sem receber resultados das outras sessões e sem alterar as skills:

- fundamentos de tarefa: 15/15 PASS;
- operações diárias: 18/18 PASS;
- famílias de negócio: 9/9 PASS;
- famílias de infraestrutura: 9/9 PASS.

Os relatórios integrais estão em `manifest/evidence/evaluations/expansion-2026-09-17/`. Como todos os casos normal, ambíguo e limite foram aprovados, as dezessete skills foram promovidas para `RV` no catálogo e no manifesto.

## Estado e limites

A promoção comprova o comportamento nos cenários sintéticos avaliados, não compatibilidade universal. Nenhuma operação fiscal, transação financeira, ativação de equipamento, impressão física ou comunicação externa foi executada.
