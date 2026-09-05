# ACBr com IA na Prática — exemplos oficiais

Repositório público dos exemplos do livro **ACBr com IA na Prática: Inteligência artificial aplicada ao dia a dia do desenvolvimento com Delphi e ACBr**, de Régys Borges da Silveira.

> Estado: preparação editorial. A estrutura e o projeto Caixa Ágil estão planejados, mas nenhum exemplo deve ser considerado compilado, executado ou revisado até que o manifesto registre essa evidência.

## Escopo

Os exemplos usam diretamente os componentes ACBr em aplicações Delphi. ACBrMonitorPLUS e ACBrLib não fazem parte deste repositório. Os fontes do ACBr não são redistribuídos aqui.

O fio condutor será o **Caixa Ágil**, uma aplicação Delphi VCL fictícia para demonstrar preparação e emissão de NFC-e exclusivamente em homologação, persistência, impressão e diagnóstico assistido por IA.

## Organização

```text
project/    aplicação evolutiva Caixa Ágil
chapters/   exemplos independentes estritamente necessários
fixtures/   dados e artefatos fictícios e anonimizados
scripts/    compilação, testes e validações
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

A versão do Delphi, a revisão dos fontes ACBr, as plataformas e as dependências serão fixadas em `docs/environment.md` antes da implementação.

## Licença

O código autoral deste repositório é distribuído sob a Apache License 2.0. Componentes e materiais de terceiros continuam sujeitos às respectivas licenças.
