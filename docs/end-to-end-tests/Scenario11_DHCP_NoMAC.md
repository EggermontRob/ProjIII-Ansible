# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 11: Een onbekende computer kan worden aangesloten op het netwerk en ontvangt een IP.
- [ ] Verbind een computer met het netwerk.
- [ ] Laat automatisch ip en DNS toewijzen door kilo1.
- [ ] Het systeem krijgt een ip tussen `172.16.1.8-172.16.1.62`
    - Controlleer met commando:
        - Linux: `ip a`
        - Windows `ipconfig`
- [ ] De DNS staat op `172.16.0.40`
    - Controlleer met commando:
        - Linux: `ip a`
        - Windows `ipconfig /all`
