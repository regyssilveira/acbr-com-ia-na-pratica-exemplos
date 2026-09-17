# Evidência — entrada guiada e diagnóstico local

Data: 2026-09-17.

Escopo: comando único, prompt preenchido, relatório HTML, prontidão, laboratório PAS/DFM/build, exercício de migração e validade dos artefatos.

Limites: nenhuma ferramenta altera IDE, checkout ACBr, projeto ou configuração fiscal. Artefatos são gravados em pasta nova; credenciais, certificados e XMLs não são coletados. Prontidão local não autoriza serviço, hardware, homologação ou produção.

Validação: `scripts/test-skill-tools.ps1` confirma saídas, metadados e autorização; `scripts/run-diagnostics-lab.ps1` confirma um evento ausente, um campo ausente, um erro e dois warnings em fixtures; `scripts/validate-all.ps1` agrega os gates.
