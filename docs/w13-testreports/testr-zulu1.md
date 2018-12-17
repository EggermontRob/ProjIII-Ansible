# Testrapport Zulu1
### Tester(s): 
- Keanu Nys
- Maximilian Leire

## Alle te testen onderdelen onderverdeeld in secties:

### Test 0: Voorbereiding
- [x] Vanuit WAN interface ping op `172.16.0.73` werkt.
- [x] Vanuit LAN interface ping op `172.16.0.70` werkt.

### Test 1: Testscript (portscan)
- [x] Voer het testscript portscan.sh uit vanop een externe server naar een interne server en kijk welke poorten allemaal open staan.
- [x] Voer het testscript portscan.sh uit vanop een interne server naar een externe server en kijk welke poorten allemaal open staan.

### Test 2: Testen van uitgaand verkeer
- [x] Een interne server kan naar een externe server pingen zoals `1.1.1.1`.
- [x] Er kan naar buiten gesurft worden vanop interne hosts/servers.

### Test 3: Testen van binnenkomend verkeer
- [x] Er kan van buitenaf via SSH met een server verbonden worden.
- [x] Er kan van buitenaf naar de interne webserver gesurft worden.
- [x] Een interne server kan succesvol een mail naar red.local sturen.
- [x] Er kan van buitenaf naar de interne fileserver gesurft worden.
