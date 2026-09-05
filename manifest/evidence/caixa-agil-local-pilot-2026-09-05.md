# Evidência do piloto local - Caixa Ágil

- Data: 5 de setembro de 2026.
- Plataforma: Win32.
- Compilador: Delphi 37.0.
- Aplicação VCL: compilada, 555 linhas, código de saída 0.
- Testes: DUnitX, 8 encontrados, 8 aprovados, 0 falhas e 0 leaks; o INI publicado e o mapeador em memória do `TACBrNFe` foram executados.
- Laboratório console: compilado e executado, código de saída 0.
- Cenários: autorização fictícia, rejeição fictícia e timeout com resultado incerto.
- Persistência: três tentativas gravadas em FireDAC/SQLite.
- Segurança: verificador de segredos executado sobre arquivos rastreados.

## Comando

```powershell
.\scripts\validate-all.ps1
```

## Limites

Não houve assinatura, geração de XML válido, chamada à SEFAZ, impressão ou evento fiscal. O mapeador ligado ao `TACBrNFe` compila e preenche somente campos técnicos; dados de emitente e tributação foram deliberadamente omitidos. Win64 não foi verificado.
