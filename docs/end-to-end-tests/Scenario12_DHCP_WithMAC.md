# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 12: Een bekende computer kan worden aangesloten op het netwerk en ontvangt een IP.
- Verbind een computer waarvan het MAC adres bekend is bij de DHCP server met het netwerk.
- Laat automatisch ip en DNS toewijzen door kilo1.
- Het systeem krijgt een ip tussen `172.16.1.3-172.16.1.7`
    - Controlleer met commando:
        - Linux: `ip a`
        - Windows `ipconfig`
- De DNS staat op `172.16.0.40`
    - Controlleer met commando:
        - Linux: `ip a`
        - Windows `ipconfig /all`
