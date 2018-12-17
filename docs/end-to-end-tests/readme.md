# End-to-end Testscenario's

### Auteur(s):
- Kenzie Coddens
- Jens Neirynck
- Artuur Fiems
- Jarne Verbeke
- Lennert Mertens
- Keanu Nys
- Mauritz Cooreman

### Scenario 1: Hoofdscenario [Volledig scenario](Scenario1_Hoofdscenario.md)
- Een client die verbind in het netwerk krijgt een IP adres toegewezen en kan volgende dingen realiseren:
- Surfen naar een adres op het internet vb. google.be
- Aanmelden op de fileserver en hierop werken (files bewerken, openen...)
- Een mail sturen vanuit green.local naar red.local

### Scenario 2: Een client kan zich ingloggen en kan een mail verzenden in het green.local netwerk een andere client ontvangt de mail [Volledig scenario](Scenario2_Mail_Sturen.md)

#### Stappen:
- Sluit een client pc0 aan.
- Sluit een client pc1 aan.
- Log in op het systeem met de gegevens gebruikersnaam `Rob` en passwoord `Test123`.
- Open de mailclient op pc0 en maak een nieuwe mail.
- Zend van pc0 een mail naar pc1 naar het email-adres `Ismail@green.local`.
- Log in op pc1 met de gegevens gebruikersnaam `Ismail` en passwoord `Test123`.
- Open de mailclient en ga naar ontvangen emails.

### Scenario 3: Een client kan de website bekijken op 172.16.0.36 [Volledig scenario](Scenario3_Website_Bekijken.md)

#### Stappen:
- Sluit een client pc0 aan.
- Log in op het systeem met de gegevens gebruikersnaam `Thomas` en passwoord `Test123`.
- Open de webbrowser.
- Maak een zoekopdracht aan naar `172.16.0.36`.
- De Wordpress pagina is zichtbaar.

### Scenario 4: De gebruiker kan zijn persoonlijke mappen bekijken en heeft schrijfrechten [Volledig scenario](Scenario4_Fileserver_Persoonlijk.md)

#### Stappen:
- Sluit een client pc0 aan.
- Log in op het systeem met de gegevens gebruikersnaam `robin` en passwoord `Test123`.
- Open de file explorer en ga naar `smb://GREEN/robin`. (GREEN = 172.16.0.35)
- Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- Test de leesrechten door de content van de home directory weer te geven `ls`.

### Scenario 5: De gebruiker kan de share van zijn gebruikersgroep bekijken en heeft schrijfrechten [Volledig scenario](Scenario5_Fileserver_Groep.md)

#### Stappen:
- Sluit een client pc0 aan.
- Log in op het systeem met de gegevens gebruikersnaam `ismail` en passwoord `Test123`.
- Open de file explorer en ga naar `smb://GREEN/itadministra`. (GREEN = 172.16.0.35)
- Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- Test de leesrechten door de content van de share weer te geven `ls`.

### Scenario 6: Er kan van green.local een mail verzonden en ontvangen worden van red.local [Volledig scenario](Scenario6_Mail_GreenToRed.md)

#### Stappen:
- Sluit een client pc0 aan.
- Sluit een windows client aan op red.local.
- Log in op het systeem met de gegevens gebruikersnaam `Lennert` en passwoord `Test123`.
- Open de mailclient op pc0 en maak een nieuwe mail.
- Zend van pc0 een email naar `GEBRUIKER@red.local`.
- Log in op een windows machine en kijk of de mail ontvangen is.

### Scenario 7: De Mariadb database kan worden gebruikt voor wordpress [Volledig scenario](Scenario7_MariaDB_Wordpress.md)

#### Stappen:
- Sluit een client pc0 aan.
- maak een zoekopdracht naar 172.16.0.36/wordpress
- vul de gegevens in zoals gewenst
- kies de database wp_mike1 als database
- indien nodig log in met username 'mike1' en passwoord 'mike1'
- launch de website en bekijk of het werkt
### Scenario 8: De Mariadb database kan worden gebruikt voor drupal [Volledig scenario](Scenario8_MariaDB_Drupal.md)

#### Stappen:
- Sluit een client pc0 aan.
- maak een zoekopdracht naar 172.16.0.7/drupal7/install.php
- vul de gegevens in zoals gewenst
- kies de database dp_echo1 als database
- surf naar 172.16.0.7/drupal7
- indien nodig log in met username 'echo1' en passwoord 'echo1'
- bekijk of de website is gelaunched
  
### Scenario 9: Een client die niet behoort tot green.local/red.local mag niet aan de servers geraken. [Volledig scenario](Scenario9_ToegangServers.md)
- Er is een client aangesloten langs de buiten zijde van het netwerk.
- De client mag niet aan de servers van green.local geraken.
- De client kan wel een mail sturen naar een client in het netwerk

### Scenario 10: De clients zijn correct geïnstalleerd met de papa server. [Volledig scenario](Scenario10_Papa_Clients.md)
- Men kan inloggen op een pc
- Deze heeft een correcte default gateway en dns server
- Mailclient is correct geïnstalleerd

### Scenario 11: Een onbekende computer kan worden aangesloten op het netwerk en ontvangt een IP. [Volledig scenario](Scenario11_DHCP_NoMAC.md)
- Verbind een computer met het netwerk.
- Laat automatisch ip en DNS toewijzen door kilo1.
- Het systeem krijgt een ip tussen `172.16.1.8-172.16.1.62`
- De DNS staat op `172.16.0.40`

### Scenario 12: Een bekende computer kan worden aangesloten op het netwerk en ontvangt een IP. [Volledig scenario](Scenario12_DHCP_WithMAC.md)  
- Verbind een computer met het netwerk.
- Laat automatisch ip en DNS toewijzen door kilo1.
- Het systeem krijgt een ip tussen `172.16.1.3-172.16.1.7`
- De DNS staat op `172.16.0.40`
