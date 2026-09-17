---
name: acbr-communication
description: Diagnostique comunicação serial, TCP, CEP, e-mail e balança em integrações Delphi com componentes ACBr, verificando endpoint, parâmetros, protocolo, encoding, timeout, hardware e concorrência.
---

# Comunicação

Escolha somente a referência aplicável:

- [Serial](references/serial.md)
- [TCP](references/tcp.md)
- [CEP](references/cep.md)
- [E-mail](references/mail.md)
- [Balança](references/balanca.md)

Registre topologia, componente, revisão, parâmetros, protocolo, operação, bytes ou frames sanitizados e tempo observado. Diferencie abrir conexão, transportar bytes, enquadrar mensagem, interpretar protocolo e aplicar regra.

Evite loops de retry sem limite, espera bloqueante na UI e logs com credenciais ou payload sensível. Não envie comandos mutáveis a equipamento ou endpoint real sem autorização.

Avalie com [eval-cases.md](references/eval-cases.md).
