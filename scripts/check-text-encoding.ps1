$ErrorActionPreference = 'Stop'

$root = Split-Path $PSScriptRoot -Parent
$extensions = @('.pas', '.dpr', '.dfm', '.ps1', '.md', '.json', '.ini', '.yml', '.yaml')
$excluded = @('.git', 'lab\output', 'Win32', 'Win64')
$strictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
$failures = [System.Collections.Generic.List[string]]::new()
$mojibake = '\u00C3[\u0080-\u00BF]|\u00C2[\u0080-\u00BF]|\u00E2\u20AC|\uFFFD'

Get-ChildItem -LiteralPath $root -Recurse -File | Where-Object {
    $file = $_
    $file.Extension -in $extensions -and -not ($excluded | Where-Object { $file.FullName -like "*$_*" })
} | ForEach-Object {
    $relative = $_.FullName.Substring($root.Length + 1)
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    try {
        $text = $strictUtf8.GetString($bytes)
    }
    catch {
        $failures.Add("UTF-8 inválido: $relative")
        return
    }

    if ($text -match $mojibake) { $failures.Add("Possível mojibake: $relative") }

    if ($_.Extension -in @('.pas', '.dpr', '.ps1') -and $text -match '[^\x00-\x7F]') {
        $hasBom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
        if (-not $hasBom) { $failures.Add("Texto não ASCII sem BOM UTF-8: $relative") }
    }
}

if ($failures.Count -gt 0) { throw ($failures -join [Environment]::NewLine) }
Write-Host 'OK: arquivos textuais válidos, sem mojibake conhecido e com BOM onde necessário.'
