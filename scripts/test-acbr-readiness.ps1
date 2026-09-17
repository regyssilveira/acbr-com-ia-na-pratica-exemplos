param([Parameter(Mandatory)] [string]$DiagnosisPath, [ValidateSet('dfe','payments','devices','text','communication')] [string]$Scenario='dfe', [string]$OutputPath)
$ErrorActionPreference = 'Stop'
$d = Get-Content -Raw -LiteralPath $DiagnosisPath | ConvertFrom-Json
$checks = @(
    [pscustomobject]@{ item='projeto'; status=$(if($d.project){'confirmado'}else{'ausente'}); evidence=$d.project.projectFile },
    [pscustomobject]@{ item='checkout ACBr'; status=$(if($d.acbr.root){'confirmado'}else{'ausente'}); evidence=$d.acbr.root },
    [pscustomobject]@{ item='revisão ACBr'; status=$(if($d.acbr.svnRevision){'confirmado'}else{'não verificado'}); evidence=$d.acbr.svnRevision },
    [pscustomobject]@{ item='credencial/certificado'; status='exige autorização'; evidence='não coletado' },
    [pscustomobject]@{ item='serviço, hardware ou homologação'; status='exige ambiente externo'; evidence=$Scenario }
)
$result = [pscustomobject]@{ scenario=$Scenario; generatedAt=(Get-Date).ToString('o'); diagnosisGeneratedAt=$d.generatedAt; checks=$checks; conclusion='prontidão local; não autoriza efeito externo' }
if ($OutputPath) { $result | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $OutputPath -Encoding utf8 } else { $result | ConvertTo-Json -Depth 6 }
