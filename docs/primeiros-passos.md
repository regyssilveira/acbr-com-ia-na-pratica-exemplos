# Primeiros passos reproduzíveis

Este piloto usa componentes Delphi ACBr, dados fictícios e simulação local. Não transmite documentos. Para executar o build, é necessário RAD Studio 13 com DUnitX e DCUs ACBr Win32 compatíveis. Leia também `docs/environment.md`.

Na raiz do repositório, selecione a tag indicada na edição do livro que está lendo e confira os caminhos locais:

```powershell
Test-Path 'C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\dcc32.exe'
Test-Path 'D:\Delphi\ACBr\Lib\Delphi\LibD37\Win32\ACBrNFe.dcu'
```

Para estudar exatamente a edição marcada, execute `git checkout <tag-da-edicao>`. Para testar mudanças ainda não publicadas, permaneça no checkout de trabalho e não atribua os resultados à tag antiga.

Se os caminhos diferirem em sua máquina, passe-os ao gate agregado (não edite os scripts nem copie DCUs sem conferir a linha de base):

```powershell
.\scripts\validate-all.ps1 `
  -RadStudioRoot 'C:\Program Files (x86)\Embarcadero\Studio\37.0' `
  -AcbrLibrary 'D:\Delphi\ACBr\Lib\Delphi\LibD37\Win32'
```

O pré-voo deve listar compilador, `ACBrNFe.dcu` e DUnitX. Depois, espere build Win32, dez testes DUnitX aprovados, os resultados locais `autorizado`, `rejeitado` e `resultado_incerto`, verificação de segredos, catálogo consistente, codificação válida e a quantidade de skills informada pelo gate. A validação de cobertura também deve localizar fontes, demos e símbolos de entrada no checkout ACBr derivado do caminho da biblioteca. `autorizado` é apenas o nome de um estado simulado; não há XML fiscal, protocolo real, impressão ou acesso à SEFAZ.

O gate recria `lab/output/caixa-agil.sqlite`. Preserve uma cópia fora da pasta de saída se precisar manter uma execução anterior. Ao falhar, registre a primeira mensagem exata, compilador, plataforma, revisão ACBr e caminhos usados; não atualize o ACBr ou altere código antes de classificar a falha.

Para exercitar os diagnósticos do capítulo 9 sem envio externo, veja `docs/laboratorio-diagnostico.md`.
