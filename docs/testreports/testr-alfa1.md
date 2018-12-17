# Testrapport alfa1

## Auteur(s) / Uitvoerder(s) testen:
- Artuur Fiems 26/11/2018
- Artuur Fiems 03/12/2018

## Uitgevoerde testen en het geleverde resultaat:

### Test 1: IP - name config

- [x] IP adres werd correct ingesteld
  - `ip a`, verwachte waarde: 172.16.0.3
- [x] DNS adres werd correct ingesteld
  - `cat /etc/resolv.conf`, verwachte waarde 172.16.0.40
- [x] FQDN werd correct ingesteld
  - Verwachte waarde: `alfa1.green.local`

### Test 2: Installatie

- [x] Installatie voert probleemloos en automatisch uit
- [x] service `dirsrv.target` draait
  - `systemctl status dirsrv.target`
- [x] service `dirsrv-admin.service` draait
  - `systemctl dirsrv-admin.service`

### Test 3: Firewall

Controleer of de meegegeven poorten open staan:
`firewall-cmd --list-all`
- [x] 80/tcp
- [x] 389/tcp
- [x] 9830/tcp
- [x] 636/tcp
- [x] 3269/tcp

### Test 4: Applicatie

- [X] Gebruiker `admin` met wachtwoord `ldapadmin` kan aanmelden in de Directory Server Admin console

### Test verslag
Alles werkt, de scripts voor het automatisch testen staan niet op de server dus dit kan niet getest worden.
Week 12, de batstest werkt en werpt geen fouten.
