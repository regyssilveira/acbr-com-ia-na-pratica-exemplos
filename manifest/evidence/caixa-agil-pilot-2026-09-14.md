# Evidência do piloto local — 14 set. 2026

Execução de `scripts/validate-all.ps1` em RAD Studio 13 / Delphi 37.0, Win32, com a linha de base ACBr descrita em `docs/environment.md`:

- pré-voo confirmou `dcc32.exe`, `ACBrNFe.dcu` e DUnitX;
- aplicação VCL e laboratório console compilaram;
- DUnitX: 10 encontrados, 10 aprovados, 0 falhas e 0 erros;
- simulação local: autorização fictícia, rejeição fictícia e resultado incerto por timeout, persistidos em SQLite;
- verificação de segredos e estrutura das cinco skills aprovadas.

Os avisos de símbolos ACBr obsoletos permaneceram no build; não foram mascarados. Não houve transmissão fiscal, XML fiscal completo, impressão ou validação Win64. O SQLite anterior do laboratório foi preservado e restaurado após o gate, com SHA-256 idêntico antes e depois.
