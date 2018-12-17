# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 10: De clients zijn correct geïnstalleerd met de papa server.
- [X] Men kan inloggen op een pc. (vb. gebruikersnaam `Rob` en passwoord `Test123`.)
- [X] Deze heeft een correcte default gateway en dns server. (D/G: 172.16.1.2; SM: 255.255.255.192; DNS: 172.16.0.40, 172.16.0.4, 172.16.0.5;)
  - Controlleer met commando:
        - Linux: `ip a`
        - Windows `ipconfig`
- [X] Mailclient is correct geïnstalleerd. (eens opstarten)
