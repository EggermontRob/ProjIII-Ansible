# Testplan lima1: Samba File Server

## Auteur testen:
- Keanu Nys

### Tests: 

Het wachtwoord van alle gebruikers op de fileserver is `Test123`.

#### 1) Run the bats script
- [ ] Alle bats tests slagen (the only test you actually need...)
  - `sudo /root/tests/runbats.sh`

#### 2) Login in a homedirectory
- [ ] Gebruiker kan inloggen in zijn homedirectory
  - `smbclient //GREEN/ismail -Uismail` dan `ls`,  gebruiker kan inloggen en files zien.
- [ ] Gebruiker kan bestanden aanmaken in zijn homedirectory.
  - `mkdir test`, directory `test` is aangemaakt
- [ ] De directory `test` is aangemaakt op de fileserver op locatie `/home/ismail`
  - `exit` en `ls /home/ismail`
  
#### 3) Login in a share
- [ ] Gebruiker kan inloggen op de share van zijn group
  - `smbclient //GREEN/itadministra -Uismail` dan `ls`,  gebruiker kan inloggen en files zien.
- [ ] Gebruiker kan bestanden aanmaken op de share van zijn group.
  - `mkdir test`, directory `test` is aangemaakt
- [ ] De directory `test` is aangemaakt op de fileserver op locatie `/srv/shares/itadministra`
  - `exit` en `ls /srv/shares/itadministra`
