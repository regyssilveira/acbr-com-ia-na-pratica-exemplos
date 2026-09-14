# Scripts

- `build-caixa-agil.ps1`: compila a aplicação VCL Win32 contra os DCUs ACBr registrados.
- `test-caixa-agil.ps1`: compila e executa a suíte DUnitX.
- `run-local-lab.ps1`: executa autorização, rejeição e timeout simulados e persiste em SQLite.
- `verify-no-secrets.ps1`: falha se Git rastrear certificado, XML, banco ou senha preenchida.
- `validate-all.ps1`: pré-voo e gate agregado do piloto; aceita `-RadStudioRoot` e `-AcbrLibrary`. Recria `lab/output/caixa-agil.sqlite`; veja `docs/primeiros-passos.md`.
