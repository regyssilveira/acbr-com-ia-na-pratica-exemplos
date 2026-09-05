# ACBr com IA na Prática — exemplos oficiais

Repositório público dos exemplos do livro **ACBr com IA na Prática: Inteligência artificial aplicada ao dia a dia do desenvolvimento com Delphi e ACBr**, de Régys Borges da Silveira.

> Estado: piloto executável. O manifesto registra build Win32, testes DUnitX e execução local simulada. Nenhuma operação fiscal externa foi realizada.

## Escopo

Os exemplos usam diretamente os componentes ACBr em aplicações Delphi. ACBrMonitorPLUS e ACBrLib não fazem parte deste repositório. Os fontes do ACBr não são redistribuídos aqui.

O fio condutor é o **Caixa Ágil**, uma aplicação Delphi VCL fictícia. O fluxo local valida configuração e venda, simula autorização, rejeição e timeout, e persiste tentativas em SQLite. O `TACBrNFe` permanece configurado somente para homologação; envio real exige perfil fiscal e credencial aprovados.

## Organização

```text
project/    aplicação evolutiva Caixa Ágil
chapters/   exemplos independentes estritamente necessários
fixtures/   dados e artefatos fictícios e anonimizados
scripts/    compilação, testes e validações
skills/     skill ACBr reutilizável apresentada no Capítulo 3
manifest/   estado e evidências de cada exemplo
docs/       ambiente e decisões técnicas
```

## Estados de evidência

`PL` planejado → `IM` implementado → `CP` compilado → `EX` executado → `RV` revisado.

Somente exemplos em `RV` podem ser tratados como tecnicamente revisados.

## Segurança

- Use apenas ambiente de homologação e dados fictícios.
- Nunca versione certificados, chaves privadas, senhas, tokens, XMLs reais ou dados de contribuintes.
- Revise comandos e código sugeridos por IA antes de executá-los.
- Não trate respostas de IA como orientação fiscal ou fonte normativa.

## Linha de base

A versão do Delphi, a revisão dos fontes ACBr, as plataformas e as dependências estão fixadas em `docs/environment.md`.

## Executar o piloto

```powershell
.\scripts\validate-all.ps1
```

O comando compila a aplicação, executa oito testes DUnitX, roda os três cenários locais, grava evidência temporária em SQLite e verifica se arquivos sensíveis foram rastreados. Os diretórios de saída são ignorados pelo Git.

## Licença

O código autoral deste repositório é distribuído sob a Apache License 2.0. Componentes e materiais de terceiros continuam sujeitos às respectivas licenças.
