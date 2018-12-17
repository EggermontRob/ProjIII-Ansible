# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 1: Hoofdscenario
- Een client die verbind in het netwerk krijgt een IP adres toegewezen en kan volgende dingen realiseren:
- Surfen naar een adres op het internet vb. google.be
- Aanmelden op de fileserver en hierop werken (files bewerken, openen...)
- Een mail sturen vanuit green.local naar red.local

### Testrapport
- [ ] Een client krijgt een IP toegewezen uit de pool van de DHCP server.
  - Als MAC gekend is een adres: `172.16.1.3` - `172.16.1.7`, als MAC niet gekend is: `172.16.1.8` - `172.16.1.62`
  - Controleren:
      - Op windows: `ipconfig`
      - Op linux: `ip a`

- [ ] Deze client kan surfen naar www.google.be
- [ ] De client kan aanmelden op de fileserver (Lima1) en kan hier files bewerken, openen...
- [ ] De client kan vanuit green.local een mail versturen naar red.local
