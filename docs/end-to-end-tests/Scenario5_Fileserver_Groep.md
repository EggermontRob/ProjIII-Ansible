# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 5: De gebruiker kan de share van zijn gebruikersgroep bekijken en heeft schrijfrechten

#### Stappen:
- [ ] Sluit een client pc0 aan.
- [ ] Log in op het systeem met de gegevens gebruikersnaam `ismail` en passwoord `Test123`.
- [ ] Open de file explorer en ga naar `smb://GREEN/itadministra`. (GREEN = 172.16.0.35)
- [ ] Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- [ ] Test de leesrechten door de content van de share weer te geven `ls`.
