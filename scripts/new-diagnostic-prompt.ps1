param(
    [Parameter(Mandatory)] [string]$DiagnosisPath,
    [Parameter(Mandatory)] [string]$Problem,
    [string]$OutputPath
)
$ErrorActionPreference = 'Stop'
$diagnosis = Get-Content -Raw -LiteralPath $DiagnosisPath | ConvertFrom-Json
$project = if ($diagnosis.project.projectFile) { $diagnosis.project.projectFile } else { '[NÃO VERIFICADO]' }
$revision = if ($diagnosis.acbr.svnRevision) { $diagnosis.acbr.svnRevision } else { '[NÃO VERIFICADO]' }
$findings = if (@($diagnosis.findings).Count) { @($diagnosis.findings) -join '; ' } else { 'nenhum achado automático; causa ainda não demonstrada' }
$prompt = @"
Investigue sem alterar arquivos e sem executar operação externa.
Problema informado: $Problem
Projeto observado: $project
Revisão ACBr observada: $revision
Coleta gerada em: $($diagnosis.generatedAt)
Validade da coleta: $($diagnosis.validUntil)
Achados automáticos: $findings

Separe fatos, hipóteses e informações ausentes. Cite arquivos e símbolos reais, escolha um único próximo experimento reversível e declare o que não foi verificado. Não solicite certificado, senha, token, XML ou dado real.
"@
if ($OutputPath) { $prompt | Set-Content -LiteralPath $OutputPath -Encoding utf8; Write-Host "OK: prompt salvo em $OutputPath" } else { $prompt }
