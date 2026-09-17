# PIXCD

Localize ACBrPIXCD, provider e demo na revisão. Confirme ambiente, escopos, autenticação, certificado quando exigido, webhook, identificador da cobrança e política de expiração.

Separe cobrança imediata, cobrança com vencimento, QR Code, consulta, devolução e webhook. Persista identificadores antes de comunicar; valide idempotência e assinatura/origem do webhook conforme o provider.

Não exponha client secret, token, chave ou payload real. Depois de timeout, consulte a cobrança pelo identificador antes de criar outra.
