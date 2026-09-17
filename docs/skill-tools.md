# Ferramentas locais das skills

Todas as ferramentas abaixo operam somente nos arquivos informados. Elas não atualizam o ACBr, não alteram a IDE e não acessam serviços externos.

## Sanitizar uma cópia de log

```powershell
.\scripts\sanitize-acbr-log.ps1 `
  -InputPath '.\privado\erro.log' `
  -OutputPath '.\saida\erro-sanitizado.log'
```

O script recusa sobrescrever o original ou uma saída existente, grava relatório com hash do original e contagem por regra e exige revisão humana. Os padrões cobrem segredos nomeados, CPF/CNPJ, e-mail e alguns elementos XML; eles não garantem anonimização completa.

## Comparar símbolos entre revisões

```powershell
.\scripts\compare-acbr-symbols.ps1 `
  -OldCheckout 'D:\ACBr-antigo' `
  -NewCheckout 'D:\ACBr-novo' `
  -Pattern 'TACBrNFe','ModeloDF' `
  -OutputPath '.\saida\comparacao.json'
```

O relatório classifica cada padrão como `added`, `removed`, `changed` ou `unchanged` e mostra ocorrências relativas à raiz. Ele não afirma compatibilidade: uma mudança de implementação pode não aparecer no padrão escolhido, e ocorrências iguais não provam comportamento igual.

## Inventariar paths e DCUs

```powershell
.\scripts\inspect-delphi-paths.ps1 `
  -ProjectFile '.\MeuProjeto.dproj' `
  -AdditionalPath 'D:\biblioteca\Win32' `
  -OutputPath '.\saida\paths.json'
```

O inventário lista paths existentes, macros/não resolvidos, paths repetidos, DCUs de mesmo nome em mais de uma pasta e raízes ACBr detectadas. Macros do MSBuild não são expandidas; confira-as dentro do ambiente do Delphi.

## Laboratórios locais

```powershell
.\scripts\run-payments-lab.ps1
.\scripts\run-text-lab.ps1
```

O laboratório de pagamentos testa quatro estados fictícios, incluindo timeout como resultado incerto e boleto gerado sem registro. O laboratório TXT gera um leiaute didático, confere hierarquia, totalização e round-trip UTF-8. Nenhum deles valida banco, PSP, TEF, obrigação fiscal ou serviço real.

## Autoteste

```powershell
.\scripts\test-skill-tools.ps1
```

O teste usa uma pasta temporária, verifica preservação do log original, remoção de valores fictícios, símbolo adicionado/removido e DCU duplicado, e remove a pasta ao terminar.

## Encontrar e instalar uma skill

```powershell
.\scripts\find-skill.ps1 -Query 'NFe rejeitada depois de atualizar o ACBr'
.\scripts\install-skills.ps1 -Skill 'acbr-problem-diagnosis'
.\scripts\install-skills.ps1 -Skill 'acbr-problem-diagnosis' -Apply
.\scripts\install-skills.ps1 -Profile dfe -CheckUpdates
```

O localizador pontua termos do problema e sempre oferece o roteador geral quando não encontra correspondência. O instalador apenas simula, a menos que `-Apply` seja informado, e cria backup datado antes de atualizar uma pasta existente.

## Preparar o contexto e escolher um fluxo

```powershell
.\scripts\new-acbr-project-context.ps1 -ProjectFile '.\Sistema.dproj' -AcbrRoot 'D:\ACBr'
.\scripts\new-acbr-project-context.ps1 -ProjectFile '.\Sistema.dproj' -AcbrRoot 'D:\ACBr' -Apply
.\scripts\start-guided-workflow.ps1 -Workflow incident -Family dfe
```

O primeiro comando simula a criação de um kit com `AGENTS.md`, `baseline.json` e `context.json`. O segundo cria o rascunho em pasta nova; os campos marcados ainda exigem revisão. O fluxo guiado apenas recomenda a combinação de skill, família, ferramenta e receita.

## Conferir PAS/DFM e resumir build

```powershell
.\scripts\check-pas-dfm.ps1 -PasFile '.\Form.pas' -DfmFile '.\Form.dfm' -OutputPath '.\saida\pas-dfm.json'
.\scripts\summarize-delphi-build.ps1 -InputPath '.\build.log' -OutputPath '.\saida\build.json'
```

Os dois scripts são somente leitura. O primeiro procura eventos do DFM sem método correspondente e componentes persistidos sem campo compatível; o segundo não diagnostica a causa, apenas preserva o primeiro erro e os warnings para investigação.

## Diagnóstico e pacote de suporte

```powershell
.\scripts\acbr-doctor.ps1 -ProjectFile '.\MeuProjeto.dproj' -AcbrRoot 'D:\ACBr' -OutputPath '.\saida\diagnostico.json'
.\scripts\new-support-bundle.ps1 -OutputDirectory '.\saida\suporte' -ProjectFile '.\MeuProjeto.dproj' -LogPath '.\erro.log' -Zip
```

O Doctor é somente leitura: inventaria o projeto, paths, DCUs e a árvore ACBr informada. O pacote sanitiza cópias de logs e cria um roteiro de relato. Sempre abra e revise o conteúdo antes de compartilhá-lo; dados não reconhecidos pelos padrões podem permanecer.

## Laboratórios de certificado e atualização

```powershell
.\scripts\run-certificate-lab.ps1
.\scripts\run-version-update-lab.ps1
```

O primeiro usa apenas metadados fictícios e não acessa o repositório de certificados. O segundo compara símbolos sintéticos para ensinar a distinguir itens mantidos, removidos e adicionados; ele não atualiza nenhum checkout.
