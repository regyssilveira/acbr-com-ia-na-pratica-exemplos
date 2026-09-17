# TCP

Confirme host, porta, DNS, TLS quando aplicável, proxy/firewall, protocolo de aplicação, framing, keepalive e timeouts separados de conexão e leitura.

Teste resolução e conexão antes do protocolo. Registre tamanho e limites das mensagens; TCP é fluxo, não preserva fronteiras de envio. Trate reconexão e repetição com idempotência quando houver efeito externo.

Não desative validação TLS como correção permanente e não exponha tokens em traces.
