# End-to-end Testraport

### Tester:
- Keanu Nys

### Scenario 5: De gebruiker kan de share van zijn gebruikersgroep bekijken en heeft schrijfrechten

#### Stappen:
- [x] Sluit een client pc0 aan.
- [x] Log in op het systeem met de gegevens gebruikersnaam `ismail` en passwoord `Test123`.
- [x] Open de file explorer en ga naar `smb://GREEN/itadministra`. (GREEN = 172.16.0.35)
- [x] Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- [x] Test de leesrechten door de content van de share weer te geven `ls`.
