# Testplan Zulu1
### Auteur(s): 
- Kenzie Coddens
- Maximilian Leire

## Alle te testen onderdelen onderverdeeld in secties:### Voorbereiding- Test dient uitgevoerd te worden op een Linux host machine naar een andere host aan de hand van 'Portscan.sh + [ipadres van de target]'.- (Indien geen redhat gebruikt wordt dienen 'nmap' en 'tcpdump' handmatig op voorhand geïnstalleerd te worden.)#### WAN-host- IP-adres: 172.16.0.74- Subnet-mask: 255.255.255.252- Default gateway: 172.16.0.73#### LAN-host
- IP-adres: 172.16.0.69
- Subnet-mask: 255.255.255.252
- Default gateway: 172.16.0.70### Test 0: Voorbereiding- [ ] Vanuit WAN interface ping op `172.16.0.73` werkt.
- [ ] Vanuit LAN interface ping op `172.16.0.70` werkt.
### Test 1: Testscript (portscan)
- [ ] Voer het testscript portscan.sh uit vanop een externe server naar een interne server en kijk welke poorten allemaal open staan.
- [ ] Voer het testscript portscan.sh uit vanop een interne server naar een externe server en kijk welke poorten allemaal open staan.
### Test 2: Testen van uitgaand verkeer
- [ ] Een interne server kan naar een externe server pingen zoals `1.1.1.1`.
- [ ] Er kan naar buiten gesurft worden vanop interne hosts/servers.

### Test 3: Testen van binnenkomend verkeer
- [ ] Er kan van buitenaf via SSH met een server verbonden worden.
- [ ] Er kan van buitenaf naar de interne webserver gesurft worden.
- [ ] Een interne server kan succesvol een mail naar red.local sturen.
- [ ] Er kan van buitenaf naar de interne fileserver gesurft worden.