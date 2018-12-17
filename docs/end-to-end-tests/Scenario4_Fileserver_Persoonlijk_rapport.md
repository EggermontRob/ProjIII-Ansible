# End-to-end Testsrapport

### Tester:
- Keanu Nys

### Scenario 4: De gebruiker kan zijn persoonlijke mappen bekijken en heeft schrijfrechten

#### Stappen:
- [x] Sluit een client pc0 aan.
- [x] Log in op het systeem met de gegevens gebruikersnaam `robin` en passwoord `Test123`.
- [x] Open de file explorer en ga naar `smb://GREEN/robin`. (GREEN = 172.16.0.35)
- [x] Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- [x] Test de leesrechten door de content van de home directory weer te geven `ls`.
