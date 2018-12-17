# Testrapport alfa1

### Auteur(s):
- Lennert Mertens
### Tester:
- Artuur Fiems
## Alle te testen onderdelen onderverdeeld in secties:

### Test 1: IP - name config

- [x] IP adres werd correct ingesteld
  - `ip a`, verwachte waarde: 172.16.0.3
- [x] DNS adres werd correct ingesteld
  - `cat /etc/resolv.conf`, verwachte waarde 172.16.0.40
- [x] FQDN werd correct ingesteld
  - `hostname -f`Verwachte waarde: `alfa1.green.local`

### Test 2: Installatie

- [x] Installatie voert probleemloos en automatisch uit
- [x] service `dirsrv.target` draait
  - `systemctl status dirsrv.target`
- [x] service `dirsrv-admin.service` draait
  - `systemctl status dirsrv-admin.service`

### Test 3: Firewall

Controleer of de meegegeven poorten open staan:
`firewall-cmd --list-all`
- [x] 80/tcp
- [x] 389/tcp
- [x] 9830/tcp
- [x] 636/tcp
- [x] 3269/tcp

### Test 4: Applicatie

- [x] Gebruiker `admin` met wachtwoord `ldapadmin` kan aanmelden in de Directory Server Admin console
