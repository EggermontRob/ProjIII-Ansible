# Testrapport Charlie 1

### Auteur(s):
- Jens Neirynck
- Alex Devlies (Tester)

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Voorbereiding
- [X] Mailserver (Delta 1) is running
- [X] FWD DNS (Quebec 1) is running
- [X] AD (Alfa 1) is running
- [X] Bravo 1 (ns1) is running

### Test 2: Basistests op Charlie
- [X] Er kan een SSH verbinding worden gemaakt naar Charlie
- [X] Ip adres komt overeen met 172.16.0.5 (ip a)
- [X] De Bind services draaien
- [X] cat /var/named/slaves/green.local heeft de juiste informatie
- [X] cat /var/named/slaves/0.16.172.in-addrp heeft de juiste informatie

### Test 3: Specifieke test op Delta 1 via Bravo
- [X] nslookup mail.green.local werkt (testen op Bravo)
- [X] nslookup 172.16.0.6 werkt (testen op Bravo)

- [X] SSH verbinding naar Delta 1 lukt
- [X] nslookup dc.green.local werkt
- [X] nslookup 172.16.0.3 werkt
- [X] dig dc.green.local werkt
- [X] dig 172.16.0.3 werkt

### Test 4: Slave replicatie test
- [X] Sluit Bravo 1 af
- [x] SSH verbinding naar Charlie maken
- [x] nslookup mail.green.local werkt (testen op Charlie)
- [x] nslookup 172.16.0.6 werkt (testen op Charlie)

- [x] SSH verbinding naar Delta 1 lukt
- [x] nslookup dc.green.local werkt
- [x] nslookup 172.16.0.3 werkt
- [x] dig dc.green.local werkt
- [x] dig 172.16.0.3 werkt
