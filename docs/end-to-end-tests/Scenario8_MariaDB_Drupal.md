# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 8: De Mariadb database kan worden gebruikt voor drupal

#### Stappen:
- [ ] Sluit een client pc0 aan.
- [ ] Maak een zoekopdracht naar `172.16.0.7/drupal7/install.php`. (als er naar `172.16.0.7/drupal7` wordt gesurft zal dit fouten geven, dat is normaal. Bij de installatie van de site zullen deze errors verdwijnen)
- [ ] Vul de gegevens in zoals gewenst.
  - [ ] Standard, Taal
- [ ] Kies de database `dp_echo1` als database.
- [ ] Vul een gewenste sitenaam en emailadres in. (ook de gegevens voor de maintanance account invullen: naam, email, wachtwoord)
- [ ] Surf naar `172.16.0.7/drupal7`.
- [ ] Indien nodig log in met username `echo1` en passwoord `echo1`.
- [ ] Bekijk of de website is gelaunched.
