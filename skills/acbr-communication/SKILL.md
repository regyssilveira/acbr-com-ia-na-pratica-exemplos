---
name: acbr-communication
description: Diagnostique comunicação serial e TCP em integrações Delphi com componentes ACBr, verificando endpoint, parâmetros, protocolo, framing, encoding, timeout e concorrência.
---

# Comunicação

Escolha somente a referência aplicável:

- [Serial](references/serial.md)
- [TCP](references/tcp.md)

Registre topologia, componente, revisão, parâmetros, protocolo, operação, bytes ou frames sanitizados e tempo observado. Diferencie abrir conexão, transportar bytes, enquadrar mensagem, interpretar protocolo e aplicar regra.

Evite loops de retry sem limite, espera bloqueante na UI e logs com credenciais ou payload sensível. Não envie comandos mutáveis a equipamento ou endpoint real sem autorização.

Avalie com [eval-cases.md](references/eval-cases.md).
