# Testplan Charlie 1

### Auteur(s): 
- Jens Neirynck

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Voorbereiding
- [ ] Mailserver (Delta 1) is running
- [ ] FWD DNS (Quebec 1) is running
- [ ] AD (Alfa 1) is running
- [ ] Bravo 1 (ns1) is running

### Test 2: Basistests op Charlie
- [ ] Er kan een SSH verbinding worden gemaakt naar Charlie
- [ ] Ip adres komt overeen met 172.16.0.5 (ip a)
- [ ] De Bind services draaien
- [ ] cat /var/named/slaves/green.local heeft de juiste informatie
- [ ] cat /var/named/slaves/0.16.172.in-addrp heeft de juiste informatie

### Test 3: Specifieke test op Delta 1 via Bravo
- [ ] nslookup mail.green.local werkt (testen op Bravo)
- [ ] nslookup 172.16.0.6 werkt (testen op Bravo)

- [ ] SSH verbinding naar Delta 1 lukt
- [ ] nslookup dc.green.local werkt
- [ ] nslookup 172.16.0.3 werkt
- [ ] dig dc.green.local werkt
- [ ] dig 172.16.0.3 werkt

### Test 4: Slave replicatie test
- [ ] Sluit Bravo 1 af
- [ ] SSH verbinding naar Charlie maken
- [ ] nslookup mail.green.local werkt (testen op Charlie)
- [ ] nslookup 172.16.0.6 werkt (testen op Charlie)

- [ ] SSH verbinding naar Delta 1 lukt
- [ ] nslookup dc.green.local werkt
- [ ] nslookup 172.16.0.3 werkt
- [ ] dig dc.green.local werkt
- [ ] dig 172.16.0.3 werkt




