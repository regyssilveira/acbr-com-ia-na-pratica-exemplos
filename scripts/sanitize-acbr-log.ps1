param(
    [Parameter(Mandatory = $true)][string]$InputPath,
    [Parameter(Mandatory = $true)][string]$OutputPath,
    [string]$ReportPath
)

$ErrorActionPreference = 'Stop'
$inputFull = (Resolve-Path -LiteralPath $InputPath).Path
$outputFull = [IO.Path]::GetFullPath($OutputPath)
if ($inputFull -eq $outputFull) { throw 'A saída deve ser diferente do arquivo original.' }
if (Test-Path -LiteralPath $outputFull) { throw "A saída já existe: $outputFull" }
if (-not $ReportPath) { $ReportPath = "$outputFull.report.json" }
$reportFull = [IO.Path]::GetFullPath($ReportPath)
if ($reportFull -eq $inputFull -or $reportFull -eq $outputFull) { throw 'O relatório precisa de caminho próprio.' }
if (Test-Path -LiteralPath $reportFull) { throw "O relatório já existe: $reportFull" }

$originalHash = (Get-FileHash -LiteralPath $inputFull -Algorithm SHA256).Hash
$text = [IO.File]::ReadAllText($inputFull)
$counts = [ordered]@{}
$rules = @(
    @{ Name='xml-sensitive'; Pattern='(?is)(<(?:CNPJ|CPF|xNome|email|chNFe|chCTe|chMDFe)>).*?(</(?:CNPJ|CPF|xNome|email|chNFe|chCTe|chMDFe)>)'; Replacement='$1[REMOVIDO]$2' },
    @{ Name='json-secret'; Pattern='(?im)("(?:password|senha|token|access_token|client_secret|csc|codigoativacao)"\s*:\s*")[^"]*(")'; Replacement='$1[REMOVIDO]$2' },
    @{ Name='key-secret'; Pattern='(?im)\b(password|senha|token|access_token|client_secret|csc|codigoativacao)\s*([=:])\s*[^\s;,]+'; Replacement='$1$2[REMOVIDO]' },
    @{ Name='email'; Pattern='(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b'; Replacement='[EMAIL-REMOVIDO]' },
    @{ Name='cpf-cnpj'; Pattern='(?<!\d)(?:\d{3}\.?\d{3}\.?\d{3}-?\d{2}|\d{2}\.?\d{3}\.?\d{3}/?\d{4}-?\d{2})(?!\d)'; Replacement='[DOCUMENTO-REMOVIDO]' }
)

foreach ($rule in $rules) {
    $matches = [regex]::Matches($text, $rule.Pattern).Count
    $counts[$rule.Name] = $matches
    if ($matches -gt 0) { $text = [regex]::Replace($text, $rule.Pattern, $rule.Replacement) }
}

$outputDirectory = Split-Path $outputFull -Parent
if (-not (Test-Path -LiteralPath $outputDirectory)) { New-Item -ItemType Directory -Path $outputDirectory | Out-Null }
$reportDirectory = Split-Path $reportFull -Parent
if (-not (Test-Path -LiteralPath $reportDirectory)) { New-Item -ItemType Directory -Path $reportDirectory | Out-Null }
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($outputFull, $text, $utf8NoBom)

$report = [ordered]@{
    input = $inputFull
    inputSha256 = $originalHash
    output = $outputFull
    replacements = $counts
    warning = 'Revisão humana obrigatória antes de compartilhar; padrões automáticos não garantem anonimização completa.'
}
[IO.File]::WriteAllText($reportFull, ($report | ConvertTo-Json -Depth 4), $utf8NoBom)
if ((Get-FileHash -LiteralPath $inputFull -Algorithm SHA256).Hash -ne $originalHash) { throw 'O arquivo original foi alterado durante a sanitização.' }

Write-Host "OK: cópia sanitizada criada em $outputFull"
Write-Host "Relatório: $reportFull"
Write-Host 'Revise manualmente a cópia antes de compartilhar.'
