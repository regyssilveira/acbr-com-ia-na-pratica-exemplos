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

    Write-Host 'OK: ferramentas de sanitização, comparação, paths, descoberta, instalação, doctor e suporte validadas.'
}
finally {
    if (Test-Path -LiteralPath $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force }
}
