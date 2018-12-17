# Opdracht quebec1

Een forwarding DNS-server voor werkstations. DNS-requests voor green.local worden geforward
naar ns[12].green.local; DNS-requests voor red.be worden geforward naar ns[12].red.local; alle
andere requests gaan naar een geschikte DNS-server die externe namen kan resolven (bv. die van
HoGent). Gebruik hiervoor Dnsmasq.