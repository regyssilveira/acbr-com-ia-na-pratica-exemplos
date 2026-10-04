# Revalidação adversarial do percurso de skills

Data: 2026-10-04. Referência de publicação: `pilot-v0.9.2`.

## Problemas encontrados e corrigidos

- O gate anterior aceitava método implementado sem declaração na classe e DFM sem os objetos do exercício. Agora exige declaração e implementação na classe correspondente, campos compatíveis e preservação dos componentes e do clique. Comentários e strings não fornecem declarações.
- O formulário não desabilitava o botão. O clique agora usa guarda de reentrada na mesma instância/thread e restaura o estado do botão em `finally`; a operação local permanece separada da interface.

## Execução observada

Comando: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-all.ps1`, ambiente documentado em `docs/environment.md`, DCUs em `D:\Delphi\ACBr\Lib\Delphi\LibD37\Win32\Release`.

- Build Win32: aprovado; avisos legados do ACBr preservados.
- DUnitX: 16 encontrados, 16 aprovados, zero falhas, erros ou vazamentos. Três testes exercitam o handler real do formulário com operação substituída, sem mostrar janela nem executar operação fiscal.
- Regressão do exercício: referência coerente aceita; oito casos rejeitados (declaração ausente, declaração comentada, implementação ausente, tipo incorreto, DFM vazio, evento removido, evento trocado, raiz renomeada).
- Testes anteriores das ferramentas e instalador, seis laboratórios, segurança, 22 skills, catálogo, codificação e 16 referências ACBr: aprovados.

## Limites

O gate PAS/DFM é uma triagem textual, não um parser Delphi completo nem substituto de compilação ou designer. Os testes de interface não comprovam concorrência entre threads, debounce de cliques enfileirados ou idempotência persistente. Nenhuma sessão de leitor iniciante, ativação nativa de skill em outra instalação, homologação, Win64 ou operação externa foi declarada realizada.
