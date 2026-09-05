# Linha de base do ambiente

Linha de base conferida em 4 de setembro de 2026:

- RAD Studio 13 Florence / Delphi 37.0;
- `bds.exe` e `dcc32.exe` 37.0.57242.3601;
- fontes ACBr obtidos do `trunk2` oficial em SourceForge, revisão SVN 47874;
- última alteração registrada nessa revisão: 21 de agosto de 2026;
- DUnitX distribuído com o RAD Studio 13;
- aplicação VCL para Windows;
- alvos planejados: Win32 e Win64;
- FireDAC com SQLite para persistência local do Caixa Ágil, executado no laboratório console.

## Checkout ACBr usado na validação

O checkout de validação está fora deste repositório. Ele contém artefatos locais não versionados e, por isso, a revisão SVN identifica a base oficial, mas não prova sozinho que a árvore local está limpa. Os exemplos devem usar apenas arquivos versionados e registrar os caminhos efetivamente compilados.

## Comandos

Os scripts chamam o compilador Delphi 37.0 diretamente e registram seu código de saída. `validate-all.ps1` agrega build, DUnitX, laboratório SQLite e varredura de segredos.

Nenhuma versão pode ser atualizada silenciosamente. Uma nova linha de base exige compilação, testes e atualização do manifesto.
