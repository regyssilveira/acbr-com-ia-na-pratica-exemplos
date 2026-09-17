param(
    [Parameter(Mandatory)]
    [ValidateSet('onboarding','integration','update','incident','support')]
    [string]$Workflow,
    [ValidateSet('dfe','payments','devices','text','communication','none')]
    [string]$Family = 'none'
)
$map = @{
    onboarding  = @{ skill='acbr-project-onboarding'; tools=@('new-acbr-project-context.ps1','acbr-doctor.ps1') }
    integration = @{ skill='acbr-integration-start'; tools=@('find-skill.ps1') }
    update      = @{ skill='acbr-version-update'; tools=@('compare-acbr-symbols.ps1','summarize-delphi-build.ps1') }
    incident    = @{ skill='acbr-problem-diagnosis'; tools=@('acbr-doctor.ps1','check-pas-dfm.ps1','summarize-delphi-build.ps1') }
    support     = @{ skill='acbr-support-request'; tools=@('new-support-bundle.ps1') }
}
$families = @{ dfe='acbr-dfe'; payments='acbr-payments'; devices='acbr-fiscal-devices'; text='acbr-text-obligations'; communication='acbr-communication'; none=$null }
$selected = $map[$Workflow]
[pscustomobject]@{
    workflow=$Workflow
    taskSkill=$selected.skill
    familySkill=$families[$Family]
    tools=$selected.tools
    next='Abra a receita mais próxima em skills/recipes.md, reúna a linha de base e execute primeiro somente leitura.'
} | ConvertTo-Json -Depth 4
