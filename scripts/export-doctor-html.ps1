param([Parameter(Mandatory)] [string]$DiagnosisPath, [Parameter(Mandatory)] [string]$OutputPath)
$ErrorActionPreference = 'Stop'
$d = Get-Content -Raw -LiteralPath $DiagnosisPath | ConvertFrom-Json
function ConvertTo-HtmlText([object]$value) { [Net.WebUtility]::HtmlEncode([string]$value) }
$findings = if (@($d.findings).Count) { (@($d.findings) | ForEach-Object { '<li>' + (ConvertTo-HtmlText $_) + '</li>' }) -join '' } else { '<li>Nenhum achado automático.</li>' }
$project = if ($d.project.projectFile) { ConvertTo-HtmlText $d.project.projectFile } else { 'não informado' }
$acbr = if ($d.acbr.root) { ConvertTo-HtmlText $d.acbr.root } else { 'não informado' }
$html = @"
<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>ACBr Doctor</title>
<style>body{font:16px system-ui;max-width:900px;margin:40px auto;padding:0 24px;color:#182b3a}h1,h2{color:#123f5d}code{background:#eef4f6;padding:2px 5px}section{border-top:1px solid #ccd9df;padding:12px 0}.note{background:#fff6d8;padding:12px}</style>
<h1>ACBr Doctor</h1><p class="note">Relatório local e somente leitura. Não comprova operação externa nem substitui revisão humana.</p>
<section><h2>Coleta</h2><p>Gerada: <code>$(ConvertTo-HtmlText $d.generatedAt)</code><br>Válida até: <code>$(ConvertTo-HtmlText $d.validUntil)</code><br>Versão: <code>$(ConvertTo-HtmlText $d.toolVersion)</code></p></section>
<section><h2>Linha de base</h2><p>Projeto: <code>$project</code><br>ACBr: <code>$acbr</code><br>Revisão: <code>$(ConvertTo-HtmlText $d.acbr.svnRevision)</code></p></section>
<section><h2>Achados</h2><ul>$findings</ul></section>
<section><h2>Regenerar quando</h2><ul>$((@($d.regenerateWhen)|ForEach-Object{'<li>'+(ConvertTo-HtmlText $_)+'</li>'}) -join '')</ul></section></html>
"@
$html | Set-Content -LiteralPath $OutputPath -Encoding utf8
Write-Host "OK: relatório HTML salvo em $OutputPath"
