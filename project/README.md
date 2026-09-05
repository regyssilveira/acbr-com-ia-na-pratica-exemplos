# Caixa Ágil

Aplicação evolutiva do livro. Contém formulário VCL, DataModule com `TACBrNFe`, configuração INI segura, venda fictícia, cálculos, mapeador técnico, serviço de emissão simulado, persistência FireDAC/SQLite e estados explícitos.

O botão **Executar laboratório local** usa o arquivo local quando existir e recorre ao INI de exemplo. Ele nunca acessa a SEFAZ: executa autorização fictícia, rejeição fictícia e timeout, exibindo o resultado e gravando as tentativas em `output/caixa-agil.sqlite`.

O mapeador preenche apenas campos técnicos do rascunho no `TACBrNFe`. Emitente, NCM, CFOP e tributação não são inventados; precisam ser fornecidos por perfil fiscal aprovado antes de qualquer validação ou envio externo.

Use `scripts/validate-all.ps1` para reproduzir todas as verificações do piloto.

Não adicione dependência proprietária, certificado ou dado real ao projeto.
