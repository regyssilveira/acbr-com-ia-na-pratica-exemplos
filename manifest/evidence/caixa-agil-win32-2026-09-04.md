# Evidência de compilação — Caixa Ágil Win32

- Data: 4 de setembro de 2026.
- RAD Studio: 13 Florence.
- Compilador: Delphi para Win32 37.0.57242.3601.
- ACBr: DCUs instaladas para Delphi 37, originadas do checkout `trunk2` usado no ambiente.
- Comando reproduzível: `scripts/build-caixa-agil.ps1`.
- Resultado inicial: código de saída 0; 139 linhas compiladas no commit `28858e6`.
- Revalidação do piloto: código de saída 0; 140 linhas compiladas após a inclusão explícita dos estados de falha técnica e resultado incerto.
- Aviso preservado: `pcnConversao` está marcado como obsoleto na biblioteca instalada.

## Limites da evidência

Esta evidência comprova somente compilação Win32 do esqueleto arquitetural. Não comprova execução de emissão, conexão com serviços, validade fiscal, compilação Win64 ou revisão final. A diferença entre as units de conversão instaladas e a API nova visível nos fontes deve ser resolvida antes de elevar o exemplo para `RV`.
