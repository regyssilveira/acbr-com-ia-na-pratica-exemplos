# Revisão coordenada de PAS e DFM

Leia PAS e DFM como uma unidade lógica sempre que a tarefa envolver formulário, DataModule, componente, propriedade publicada ou evento.

Confira:

- nome e classe de cada componente;
- campos declarados e objetos persistidos;
- propriedades configuradas no DFM e sobrescritas em código;
- eventos e métodos associados;
- Owner, ordem de criação e referências inicializadas;
- remoção, renomeação e destruição;
- alteração de propriedades publicadas entre revisões do ACBr.

Uma mudança estrutural só está coerente quando os dois lados foram avaliados, o formulário ou DataModule pôde ser carregado e o alvo declarado compilou. Não regrave o DFM inteiro para efetuar uma alteração localizada.
