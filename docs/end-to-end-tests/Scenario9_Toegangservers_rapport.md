# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 9: Een client die niet behoort tot green.local/red.local mag niet aan de servers geraken.
- [X] Er is een client aangesloten langs de buiten zijde van het netwerk.
- [X] De client mag niet aan de servers van `green.local` geraken.
    - dit kan eventueel getest worden door te surfen naar de webserver `172.16.0.7/drupal7`
- [X] De client kan geen mail sturen naar een client in het netwerk.
