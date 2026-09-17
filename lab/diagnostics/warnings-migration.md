# Exercício: migrar APIs obsoletas sem adivinhar

O Caixa Ágil ainda expõe warnings de `pcnConversao`, `tnSaida`, `taHomologacao` e `tiNFCe`. O exercício não fornece substituições prontas: a revisão instalada é a fonte da verdade.

1. registre o build atual e resuma os warnings;
2. localize cada declaração e mensagem de obsolescência nos fontes ACBr usados pelo compilador;
3. confirme unit e tipo atuais em uma demo da mesma revisão;
4. proponha uma alteração por vez, preservando PAS/DFM;
5. recompile e execute os dez testes;
6. compare warnings antes/depois e registre o que não foi testado em homologação.

Compilar sem warnings não comprova equivalência de comportamento. Não altere regra fiscal para eliminar aviso técnico.
