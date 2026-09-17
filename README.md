# ACBr com IA na Prática — exemplos oficiais

Repositório público dos exemplos do livro **ACBr com IA na Prática: Inteligência artificial aplicada ao dia a dia do desenvolvimento com Delphi e ACBr**, de Régys Borges da Silveira.

> Estado: piloto executável. O manifesto registra build Win32, testes DUnitX e execução local simulada. Nenhuma operação fiscal externa foi realizada.

Versão correspondente à edição candidata do livro: `pilot-v0.7.0`.

## Escopo

Os exemplos usam diretamente os componentes ACBr em aplicações Delphi. ACBrMonitorPLUS e ACBrLib não fazem parte deste repositório. Os fontes do ACBr não são redistribuídos aqui.

O fio condutor é o **Caixa Ágil**, uma aplicação Delphi VCL fictícia. O fluxo local valida configuração e venda, simula autorização, rejeição e timeout, e persiste tentativas em SQLite. O `TACBrNFe` permanece configurado somente para homologação; envio real exige perfil fiscal e credencial aprovados.

## Organização

```text
project/    aplicação evolutiva Caixa Ágil
chapters/   exemplos independentes estritamente necessários
fixtures/   dados e artefatos fictícios e anonimizados
scripts/    compilação, testes e validações
skills/     suíte de skills ACBr reutilizáveis
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

O comando faz um pré-voo da instalação, compila a aplicação, executa dez testes DUnitX, roda os três cenários locais, grava evidência temporária em SQLite e verifica se arquivos sensíveis foram rastreados. Os diretórios de saída são ignorados pelo Git. Para informar caminhos próprios e conferir a saída esperada, siga [Primeiros passos reproduzíveis](docs/primeiros-passos.md). O gate recria o SQLite local do laboratório.

## Skills ACBr

A suíte começa por `skills/acbr-component-work`, que faz a triagem geral. O catálogo reúne skills para conhecer projetos, iniciar integrações, ambiente, atualização, build, execução, testes, configuração, respostas, evidências, desempenho, segurança, suporte e revisão. Famílias complementares cobrem DF-e, pagamentos, SAT, SPED/TXT, impressão e comunicação.

Cada skill declara limites de segurança e casos de avaliação próprios. Consulte as [receitas de uso diário](skills/recipes.md) para começar por um problema concreto. Execute `scripts/validate-all.ps1` para validar estrutura, catálogo, codificação e correspondência das referências com fontes e demos do checkout ACBr, além dos gates do Caixa Ágil.

As [ferramentas locais](docs/skill-tools.md) incluem sanitização assistida de logs, comparação de símbolos entre revisões, inventário de paths/DCUs e laboratórios fictícios de pagamentos e TXT. Todas operam sem comunicação externa; leia os limites antes de interpretar o resultado.

Para descobrir por onde começar, execute `scripts/find-skill.ps1` ou escolha um dos cinco fluxos de `scripts/start-guided-workflow.ps1`. O instalador `scripts/install-skills.ps1` aceita perfis e trabalha em modo de simulação por padrão. `scripts/new-acbr-project-context.ps1` prepara um rascunho de contexto persistente; `scripts/acbr-doctor.ps1` produz diagnóstico somente de leitura; e `scripts/new-support-bundle.ps1` reúne evidências sanitizadas para revisão antes do compartilhamento.

Veja a [árvore de decisão e as instruções de adoção](skills/README.md). O estado de cada pacote está em [catalog.json](skills/catalog.json); itens `IM` ainda não passaram por avaliação comportamental independente. As skills usam diretamente o formato do Codex; referências, scripts e avaliações podem ser adaptados a outros agentes conforme a [matriz de compatibilidade](skills/compatibility.md), sem presumir descoberta automática.

## Licença

O código autoral deste repositório é distribuído sob a Apache License 2.0. Componentes e materiais de terceiros continuam sujeitos às respectivas licenças.
