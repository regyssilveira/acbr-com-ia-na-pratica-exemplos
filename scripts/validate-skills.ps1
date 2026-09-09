$ErrorActionPreference = 'Stop'

$skillsRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'skills'
$skillDirectories = @(Get-ChildItem -LiteralPath $skillsRoot -Directory | Sort-Object Name)

if ($skillDirectories.Count -eq 0) {
    throw 'Nenhuma skill encontrada.'
}

foreach ($directory in $skillDirectories) {
    if ($directory.Name -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
        throw "Nome de diretório inválido: $($directory.Name)"
    }

    $skillFile = Join-Path $directory.FullName 'SKILL.md'
    if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
        throw "SKILL.md ausente: $($directory.Name)"
    }

    $content = Get-Content -Raw -LiteralPath $skillFile
    if ($content -notmatch '(?s)^---\s*\r?\nname:\s*([^\r\n]+)\r?\ndescription:\s*([^\r\n]+)\r?\n---') {
        throw "Frontmatter inválido: $($directory.Name)"
    }

    if ($Matches[1].Trim() -ne $directory.Name) {
        throw "O nome no frontmatter não corresponde ao diretório: $($directory.Name)"
    }

    if ($Matches[2].Trim().Length -lt 40) {
        throw "Descrição pouco discriminante: $($directory.Name)"
    }

    foreach ($reference in [regex]::Matches($content, '\]\((references/[^)]+)\)')) {
        $target = Join-Path $directory.FullName $reference.Groups[1].Value
        if (-not (Test-Path -LiteralPath $target -PathType Leaf)) {
            throw "Referência ausente em $($directory.Name): $($reference.Groups[1].Value)"
        }
    }

    if ($content -cmatch '\bTODO\b|\bTBD\b|Your skill|replace this') {
        throw "Placeholder encontrado: $($directory.Name)"
    }
}

Write-Host "OK: $($skillDirectories.Count) skills validadas."
