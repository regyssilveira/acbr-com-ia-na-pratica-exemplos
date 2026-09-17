$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$tempRoot = Join-Path ([IO.Path]::GetTempPath()) ("acbr-skill-tools-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $tempRoot | Out-Null

try {
    # Sanitização: cria cópia, remove valores e preserva hash do original.
    $log = Join-Path $tempRoot 'input.log'
    $sanitized = Join-Path $tempRoot 'sanitized.log'
    [IO.File]::WriteAllText($log, "token=FAKE-ONLY`n<CNPJ>11222333000181</CNPJ>`ncontato@example.invalid", [Text.UTF8Encoding]::new($false))
    $before = (Get-FileHash $log -Algorithm SHA256).Hash
    & (Join-Path $PSScriptRoot 'sanitize-acbr-log.ps1') -InputPath $log -OutputPath $sanitized
    if ((Get-FileHash $log -Algorithm SHA256).Hash -ne $before) { throw 'Sanitizador alterou o original.' }
    $clean = [IO.File]::ReadAllText($sanitized)
    if ($clean -match 'FAKE-ONLY|11222333000181|contato@example') { throw 'Sanitizador preservou valor de teste sensível.' }

    # Comparação: detecta símbolo removido e adicionado entre duas árvores sintéticas.
    $old = Join-Path $tempRoot 'old'
    $new = Join-Path $tempRoot 'new'
    New-Item -ItemType Directory -Path "$old\Fontes", "$new\Fontes" | Out-Null
    [IO.File]::WriteAllText("$old\Fontes\Demo.pas", "unit Demo; type TOldSymbol = class;", [Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllText("$new\Fontes\Demo.pas", "unit Demo; type TNewSymbol = class;", [Text.UTF8Encoding]::new($false))
    $comparisonPath = Join-Path $tempRoot 'comparison.json'
    & (Join-Path $PSScriptRoot 'compare-acbr-symbols.ps1') -OldCheckout $old -NewCheckout $new -Pattern @('TOldSymbol','TNewSymbol') -OutputPath $comparisonPath
    $comparison = Get-Content -Raw $comparisonPath | ConvertFrom-Json
    if (($comparison | Where-Object pattern -eq 'TOldSymbol').status -ne 'removed') { throw 'Comparador não detectou remoção.' }
    if (($comparison | Where-Object pattern -eq 'TNewSymbol').status -ne 'added') { throw 'Comparador não detectou adição.' }

    # Paths/DCUs: detecta mesmo DCU em duas pastas e mantém macro como não resolvida.
    $libA = Join-Path $tempRoot 'libA'
    $libB = Join-Path $tempRoot 'libB'
    New-Item -ItemType Directory -Path $libA, $libB | Out-Null
    [IO.File]::WriteAllBytes((Join-Path $libA 'ACBrDemo.dcu'), [byte[]](1,2,3))
    [IO.File]::WriteAllBytes((Join-Path $libB 'ACBrDemo.dcu'), [byte[]](4,5,6))
    $project = Join-Path $tempRoot 'Demo.dproj'
    $projectXml = @"
<Project><PropertyGroup><DCC_UnitSearchPath>$libA;$libB;`$(UNRESOLVED)</DCC_UnitSearchPath><DCC_DcuOutput></DCC_DcuOutput></PropertyGroup></Project>
"@
    [IO.File]::WriteAllText($project, $projectXml, [Text.UTF8Encoding]::new($false))
    $pathsReport = Join-Path $tempRoot 'paths.json'
    & (Join-Path $PSScriptRoot 'inspect-delphi-paths.ps1') -ProjectFile $project -OutputPath $pathsReport
    $paths = Get-Content -Raw $pathsReport | ConvertFrom-Json
    if (@($paths.duplicateDcus).Count -ne 1) { throw 'Inventário não detectou DCU duplicado.' }
    if (@($paths.unresolvedOrMacroPaths).Count -ne 1) { throw 'Inventário não preservou macro não resolvida.' }

    # Descoberta: problema comum de rejeição deve encaminhar para diagnóstico.
    $finder = (& (Join-Path $PSScriptRoot 'find-skill.ps1') -Query 'analisar rejeição depois de atualizar o ACBr' -AsJson | Out-String | ConvertFrom-Json)
    if (@($finder)[0].skill -ne 'acbr-problem-diagnosis') { throw 'Localizador não priorizou diagnóstico para rejeição.' }

    # Instalador: simulação não pode criar o destino; aplicação deve instalar uma skill.
    $installRoot = Join-Path $tempRoot 'installed'
    & (Join-Path $PSScriptRoot 'install-skills.ps1') -Destination $installRoot -Skill 'acbr-dfe'
    if (Test-Path -LiteralPath $installRoot) { throw 'Simulação do instalador alterou o destino.' }
    & (Join-Path $PSScriptRoot 'install-skills.ps1') -Destination $installRoot -Skill 'acbr-dfe' -Apply
    if (-not (Test-Path -LiteralPath (Join-Path $installRoot 'acbr-dfe\SKILL.md'))) { throw 'Instalador não copiou a skill.' }

    # Doctor e pacote: trabalham em cópias e exigem pasta de saída nova.
    $doctor = Join-Path $tempRoot 'doctor.json'
    & (Join-Path $PSScriptRoot 'acbr-doctor.ps1') -ProjectFile $project -OutputPath $doctor
    if (-not (Test-Path -LiteralPath $doctor)) { throw 'Doctor não criou relatório.' }
    $bundle = Join-Path $tempRoot 'support'
    & (Join-Path $PSScriptRoot 'new-support-bundle.ps1') -OutputDirectory $bundle -ProjectFile $project -LogPath $log
    if (-not (Test-Path -LiteralPath (Join-Path $bundle 'pedido-de-suporte.md'))) { throw 'Pacote de suporte incompleto.' }

    # PAS/DFM: par sintético coerente não deve produzir pendências.
    $pairPas = Join-Path $tempRoot 'Pair.pas'
    $pairDfm = Join-Path $tempRoot 'Pair.dfm'
    [IO.File]::WriteAllText($pairPas, "unit Pair;`ntype TForm1 = class(TForm)`n  Button1: TButton;`n  procedure Button1Click(Sender: TObject);`nend;`nprocedure TForm1.Button1Click(Sender: TObject); begin end;`nend.", [Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllText($pairDfm, "object Form1: TForm1`n  object Button1: TButton`n    OnClick = Button1Click`n  end`nend", [Text.UTF8Encoding]::new($false))
    $pairReport = Join-Path $tempRoot 'pair.json'
    & (Join-Path $PSScriptRoot 'check-pas-dfm.ps1') -PasFile $pairPas -DfmFile $pairDfm -OutputPath $pairReport
    $pair = Get-Content -Raw $pairReport | ConvertFrom-Json
    if (@($pair.missingEventHandlers).Count -or @($pair.missingComponentFields).Count) { throw 'Verificador PAS/DFM rejeitou par coerente.' }

    # Build: preserva primeiro erro e contagem de warnings.
    $buildLog = Join-Path $tempRoot 'build.log'
    [IO.File]::WriteAllText($buildLog, "Demo.pas(1) Warning: W1000 aviso`nDemo.pas(2) Error: E2003 Undeclared identifier", [Text.UTF8Encoding]::new($false))
    $buildReport = Join-Path $tempRoot 'build.json'
    & (Join-Path $PSScriptRoot 'summarize-delphi-build.ps1') -InputPath $buildLog -OutputPath $buildReport
    $build = Get-Content -Raw $buildReport | ConvertFrom-Json
    if ($build.errorCount -ne 1 -or $build.warningCount -ne 1) { throw 'Resumo de build perdeu erros ou warnings.' }

    # Kit de contexto e fluxo guiado permanecem somente leitura até Apply.
    $fakeAcbr = Join-Path $tempRoot 'ACBr'
    New-Item -ItemType Directory -Path (Join-Path $fakeAcbr 'Fontes') | Out-Null
    $contextDir = Join-Path $tempRoot 'context'
    & (Join-Path $PSScriptRoot 'new-acbr-project-context.ps1') -ProjectFile $project -AcbrRoot $fakeAcbr -OutputDirectory $contextDir
    if (Test-Path -LiteralPath $contextDir) { throw 'Simulação do kit de contexto alterou o destino.' }
    & (Join-Path $PSScriptRoot 'new-acbr-project-context.ps1') -ProjectFile $project -AcbrRoot $fakeAcbr -OutputDirectory $contextDir -Apply
    if (-not (Test-Path -LiteralPath (Join-Path $contextDir 'AGENTS.md'))) { throw 'Kit de contexto incompleto.' }
    $workflow = (& (Join-Path $PSScriptRoot 'start-guided-workflow.ps1') -Workflow incident -Family dfe | Out-String | ConvertFrom-Json)
    if ($workflow.taskSkill -ne 'acbr-problem-diagnosis' -or $workflow.familySkill -ne 'acbr-dfe') { throw 'Fluxo guiado roteou incorretamente.' }

    # Entrada única: gera diagnóstico versionado, prompt, HTML e prontidão em pastas novas.
    $unified = Join-Path $tempRoot 'unified'
    & (Join-Path $PSScriptRoot 'acbr-ai.ps1') diagnose -ProjectFile $project -AcbrRoot $fakeAcbr -Problem 'erro fictício' -Family dfe -OutputDirectory $unified
    foreach ($name in @('diagnostico.json','prompt.md','relatorio.html')) { if (-not (Test-Path (Join-Path $unified $name))) { throw "Saída unificada ausente: $name" } }
    $unifiedDiagnosis = Get-Content -Raw (Join-Path $unified 'diagnostico.json') | ConvertFrom-Json
    if ($unifiedDiagnosis.schemaVersion -ne 2 -or -not $unifiedDiagnosis.validUntil) { throw 'Metadados de validade ausentes no diagnóstico.' }
    $readyDir = Join-Path $tempRoot 'ready'
    & (Join-Path $PSScriptRoot 'acbr-ai.ps1') ready -ProjectFile $project -AcbrRoot $fakeAcbr -Family dfe -OutputDirectory $readyDir
    $ready = Get-Content -Raw (Join-Path $readyDir 'prontidao.json') | ConvertFrom-Json
    if (@($ready.checks | Where-Object status -eq 'exige autorização').Count -ne 1) { throw 'Prontidão não preservou autorização externa.' }

    # Perfil instala somente o conjunto selecionado.
    $profileRoot = Join-Path $tempRoot 'profile'
    & (Join-Path $PSScriptRoot 'install-skills.ps1') -Destination $profileRoot -Profile payments -Apply
    if (-not (Test-Path (Join-Path $profileRoot 'acbr-payments\SKILL.md')) -or (Test-Path (Join-Path $profileRoot 'acbr-dfe'))) { throw 'Perfil de instalação incorreto.' }

    Write-Host 'OK: ferramentas de contexto, PAS/DFM, build, fluxos, perfis, sanitização, comparação, paths, doctor e suporte validadas.'
}
finally {
    if (Test-Path -LiteralPath $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force }
}
