# NFe e NFCe

## Contexto mínimo

- modelo 55 ou 65, UF, ambiente, emissão normal/contingência e finalidade;
- revisão ACBr, versão do documento, schemas e provider de certificado;
- componente principal, DANFE/ESC-POS associado e local de persistência dos XMLs;
- regra fiscal aprovada para emitente, destinatário, itens, totais e pagamentos.

## Fluxo verificável

1. Localize `TACBrNFe` e a demo NFe na revisão instalada.
2. Confira configuração sem expor certificado ou CSC.
3. Teste preenchimento e validação com massa fictícia antes de comunicação.
4. Modele autorização, rejeição, duplicidade, consulta e resultado incerto.
5. Trate cancelamento, inutilização, carta de correção e impressão como fluxos separados.

Nunca conclua que um XML é fiscalmente correto apenas porque passou no schema. NFC-e exige atenção própria a CSC, QR Code, impressão e contingência, sempre conforme regra e documentação vigentes.
