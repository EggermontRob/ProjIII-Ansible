# Testrapport alfa1

## Auteur(s) / Uitvoerder(s) testen:
- Artuur Fiems tester 19/11


## Uitgevoerde testen en het geleverde resultaat:

### Test 1: IP - name config

- [x] IP adres werd correct ingesteld
  - `ip a`, verwachte waarde: 172.16.0.3
- [x] DNS adres werd correct ingesteld
  - `cat /etc/resolv.conf`, verwachte waarde 172.16.0.40 ---> stond 4 maar is niet correct
- [ ] FQDN werd correct ingesteld
  - Verwachte waarde: `alfa1.green.local`

### Test 2: Installatie

- [x] Installatie voert probleemloos en automatisch uit
- [] service `dirsrv.target` draait
  - `systemctl status dirsrv.target`
- [] service `dirsrv-admin.service` draait
  - `systemctl status dirsrv.target`

### Test 3: Firewall

Controleer of de meegegeven poorten open staan:
`firewall-cmd --list-all`
- [x] 80/tcp
- [x] 389/tcp
- [x] 9830/tcp
- [x] 636/tcp
- [x] 3269/tcp

### Test 4: Applicatie

- [ ] Gebruiker `admin` met wachtwoord `ldapadmin` kan aanmelden in de Directory Server Admin console
