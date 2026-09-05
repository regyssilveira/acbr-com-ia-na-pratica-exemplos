$ErrorActionPreference = 'Stop'

& (Join-Path $PSScriptRoot 'build-caixa-agil.ps1')
& (Join-Path $PSScriptRoot 'test-caixa-agil.ps1')
& (Join-Path $PSScriptRoot 'run-local-lab.ps1')
& (Join-Path $PSScriptRoot 'verify-no-secrets.ps1')

Write-Host 'OK: build, testes, laboratório e segurança concluídos.'
