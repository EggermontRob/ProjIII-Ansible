# Testplan alfa1

### Auteur(s):
- Lennert Mertens

## Alle te testen onderdelen onderverdeeld in secties:

### Test 1: IP - name config

- [ ] IP adres werd correct ingesteld
  - `ip a`, verwachte waarde: 172.16.0.3
- [ ] DNS adres werd correct ingesteld
  - `cat /etc/resolv.conf`, verwachte waarde 172.16.0.40
- [ ] FQDN werd correct ingesteld
  - Verwachte waarde: `alfa1.green.local`

### Test 2: Installatie

- [ ] Installatie voert probleemloos en automatisch uit
- [ ] service `dirsrv.target` draait
  - `systemctl status dirsrv.target`
- [ ] service `dirsrv-admin.service` draait
  - `systemctl dirsrv-admin.service`

### Test 3: Firewall

Controleer of de meegegeven poorten open staan:
`firewall-cmd --list-all`
- [ ] 80/tcp
- [ ] 389/tcp
- [ ] 9830/tcp
- [ ] 636/tcp
- [ ] 3269/tcp

### Test 4: Applicatie

- [ ] Gebruiker `admin` met wachtwoord `ldapadmin` kan aanmelden in de Directory Server Admin console
