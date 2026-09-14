# Laboratório local de diagnóstico

Os dois defeitos abaixo são reproduzidos por testes DUnitX, sem modificar o INI de exemplo e sem acessar serviço fiscal. Execute da raiz:

```powershell
.\scripts\test-caixa-agil.ps1
```

Se a instalação estiver em outros caminhos, informe `-RadStudioRoot` e `-AcbrLibrary` como em `docs/primeiros-passos.md`. A execução esperada informa `Tests Found : 10`, `Tests Passed : 10` e nenhuma falha.

## Pasta de schemas inexistente

Leia `MissingSchemaDirectoryIsRejected` em `tests/CaixaAgil.Tests.Domain.pas` e `TFiscalConfiguration.ValidateLocal` em `project/CaixaAgil/src/CaixaAgil.Configuration.pas`. O teste fornece uma pasta temporária com nome aleatório que não existe. A evidência esperada é `EDirectoryNotFoundException` antes de qualquer gateway. Hipótese: o caminho local está errado; experimento: comparar `SchemaPath` com uma pasta existente; limite: isto não valida um XML contra um schema.

## Timeout após tentativa simulada

Leia `TimeoutBecomesUncertainResult` no mesmo arquivo de testes, `TSimulatedEmissionGateway.Submit` e `TEmissionService.Emit` em `project/CaixaAgil/src/CaixaAgil.Application.Emission.pas`. O gateway retorna um timeout simulado, e o estado esperado é `esUncertainResult`, nunca rejeição ou autorização. Rode também `scripts/run-local-lab.ps1` para observar os três estados gravados em SQLite. Hipótese de investigação: uma tradução incorreta transformaria a incerteza em rejeição; experimento: conferir a transição e o teste antes de mudar o serviço. Não há envio nem consulta externa neste caso.

Para treinar a IA, entregue apenas o sintoma e os arquivos pertinentes; peça fatos, hipóteses, próximo experimento e critério de parada. Compare a resposta com estes resultados somente depois. Não introduza uma falha proposital no código principal nem use credenciais reais.
