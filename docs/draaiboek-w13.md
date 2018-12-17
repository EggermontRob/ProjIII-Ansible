# Draaiboek Deployment week 13

Dit document beschrijft alle stappen die tijdens de oplevering worden doorlopen.

## Algemene afspraken

Iedereen heeft recht op pauze, snel eens naar toilet gaan is uiteraard geen enkel probleem maar bij voorkeur toch drinken/eten meebrengen naar het lokaal.
- Niet iedereen gaat tegelijk weg, verdeel dit
- Iedereen blijft bereikbaar
- We zijn een team, de opdracht is NIET gedaan als jouw deeltje af is, iedereen kan bijdragen en helpen indien er moet worden

De deployment duurt van 8:15-11:30

## Kanbanbord week 13
Er zal gewerkt worden met een bord met post-its waarop we alle taken zullen plaatsen. Het bord bestaat uit volgende onderdelen:

### Onderdelen

- Ready
- In progress
- Errors (high priority)
- Errors (low priority)
- Testing
- Done


## Planning
### 8:00: Aanwezigheid
- Iedereen is aanwezig en weet wat er van hem verwacht wordt

### 8:15: Intro + Kanbanbord + Draaiboek overlopen
### 8:20

**Good luck and may the odds be ever in our favor...**
### 8:00
#### 1. Netwerk configuratie
##### Geschatte tijd 25 minuten
Leden:
  - Michiel

Functie:
  - Zorgen voor een werkend netwerk, zowel binnen het linux-domain als naar het windows-domain

Taken:
  - Kabels
  - Router configuraties
  - Switch configuraties
  - Inter-vlan routing

Testen:
  - [ ] Config files switch ingeladen
  - [ ] Inter-VLAN routing testen adhv pings, hierna routers pingen en hierna Windows-domein

Opmerkingen/problemen:

### 8:15
#### 2. Opstart ESXI
Leden:
  - Rob
  - Ismail
  - Lennert

Functie:
  - Terugzetten van de snapshots
  - Deployment van de VMs op de Server via ESXI

Testen:
  - [ ] VMs zijn aanwezig op de server

Opmerkingen/problemen:

### 8:20 Provisioning
### 3. Servers

#### Quebec1: Forwarding DNS
##### Geschatte tijd 25 minuten
Leden:
  - Artuur
  - Jarne

Functie:
  - Quebec1 is de Forwarding DNS en moet onderscheid kunnen maken tussen een request lokaal of een request naar buiten toe. De requests lokaal worden bijgehouden in een cache zodat wanneer datzelfde request nog eens wordt opgevraagd er vlotter verbinding is.

Taken:
  - Dnsmasq moet de juiste instellingen hebben
  - Testrapporten uitvoeren

Testen:
  - [ ] testr-quebec1.md

Opmerkingen/problemen:


Afhankelijk van:
  - Bij het opzoeken van lokale requests moeten de DNS servers bravo1 & charlie1 up & running zijn.


#### Bravo1 & Charlie1: DNS
##### Geschatte tijd 20 minuten
Leden:
  - Jens
  - Max
  - Kenzie

Functie:
  - Bravo en Charlie zitten in een master/slave verhouding. Zij zorgen ervoor dat de servers te bereiken zijn binnen green.local
  - Bravo is de Master
  - Charlie is de Slave

Taken:
  - Nakijken of elke server de juiste DNS instellingen heeft
  - Testrapporten uitvoeren

Testen:
  - [ ] testr-bravo1.md
  - [ ] testr-charlie1.md

Opmerkingen/problemen:
  - momenteel geen.

Afhankelijk van:
  - Quebec 1, deze wordt ingesteld bij de servers als primary DNS.
    --> Bravo 1 kan als backup worden gezet bij problemen.


#### Kilo1: DHCP
##### Geschatte tijd 8 minuten
Leden:
  - Alex

Functie:
  - Kilo1 doet dienst als DHCP server voor het green.local domein en moet IP adressen uitdelen aan clients.

Taken:
  - Kilo 1 is verantwoordelijk voor het uitdelen van IP adressen aan de 5 bestaande clients, dit op basis van hun (meegegeven) MAC-adres. Voor clients die er in de toekomst bij kunnen komen is een pool met adressen gereserveerd.

Testen:
  - [ ] Testen als de dhcpd service succesvol gestart wordt op de server.
  - [ ] Testen als clients via hun MAC adres het correcte IP gegeven worden.

Opmerkingen/problemen:
  -

Afhankelijk van:
  - Router(multilayerswitch) van VLAN 30 die de DHCP-Requests kan forwarden naar vlan 20 (clients).
  - Verder geen afhankelijkheden.


#### Papa1: PXE
##### Geschatte tijd 5 minuten
Leden:  
  - Thibo
  - Niel

Functie:  
  - PXEServer die er moet voor zorgen dat werkstations kunnen booten vanop het netwerk.
    Ervoor zorgen dat werkstations:
      - een OS krijgen (CentOS of Fedora 28)
      - kunnen aanmelden
      - applicaties kunnen gebruiken
      - toegang hebben tot de netwerkshares

Taken:  
  - Uitvoeren van Ansible taken uit site.yml  
  - 2 pc's opzetten met VirtualBox die ieder een OS testen

Testen:  
  - [ ] de server werd zonder problemen gedeployed
  - [ ] de boot files werden gedownload
  - [ ] vsftpd en xinetd services werden gestart
  - [ ] clïent krijgt een IP-adres van de DHCP
  - [ ] cliënt heeft verbinding met de PXEServer
  - [ ] netwerkboot
  - [ ] CentOS wordt zonder problemen geïnstalleerd
  - [ ] Fedora 28 wordt zonder problemen geïnstalleerd

Opmerkingen/problemen:  

Afhankelijk van:  
  - kilo1 (DHCP)
  - Placeholder voor afhankelijkheden


#### Alfa1: 389 AD
##### Geschatte tijd 20 minuten
Leden:
  - Ismail
  - Lennert

Functie:
  - Server die fungeert als AD binnen het domein. Bruikbare user accounts en afdelingen worden op deze server geïnstalleerd.

Taken:
  - Uitvoeren Ansible role voor automatisch opzetten van de 389-ds
  - Bash script uitvoeren voor het toevoegen van gebruikers en groepen

Testen:
  - [ ] Directory server draait
  - [ ] Aanmelden via admin console (met admin credentials) is mogelijk
  - [ ] Bash script voegt groepen (OU's) toe
  - [ ] Bash script voegt gebruikers toe
  - [ ] Gebruikers en groepen (OU's) zijn zichtbaar in de admin-console
  - [ ] Testcommando's moeten allemaal slagen!

Opmerkingen/problemen:
  - Installatie van packages en configuratie van de server gebeurt via Ansible. Het toevoegen van gebruikers gebeurt via een Bash-sccript.


#### Delta1: Mail
##### Geschatte tijd 12 minuten
Leden:
  - Rob
  - Robin

Functie:
  - Delta wordt gebruikt als mailserver binnen dit domein.

Taken:
  - Dit betekend dat je via deze weg mail's zal kunnen sturen/ontvangen

Testen:
  - [testplan](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/delta1/Testplan.md)

Opmerkingen/problemen:
  - Placeholder voor bijkomende informatie of mogelijke (gekende) problemen

Afhankelijk van:
  - Placeholder voor afhankelijkheden


#### November1: MariaDB
##### Geschatte tijd 20 minuten
Leden:
  - Mauritz

Functie:
  - Server die de Mariadb-databases verstrekt voor delta1 en mike1

Taken:
  - Mariadb opstarten
  - Databases echo1 en mike1 aanmaken
  - Bijhorende users toevoegen
  - Performantie bekijken

Testen:
  - [ ] de server draait en is geprovisioned
  - [ ] testcommando's
  - [ ] uitvoeren tests met echo1 en mike1

Opmerkingen/problemen:
  -

Afhankelijk van:


#### Echo1: Webserver
##### Geschatte tijd 20 minuten
Leden:
  - Dennis
  - Julian

Functie:
  - Webhost server voor een website zoals bv. wordpress of drupal

Taken:
  - Benodigde software installeren
  - Services opstarten
  - Firewall aanpassen
  - Website opstellen

Testen:
  - Website is toegankelijk via webbrowser

Opmerkingen/problemen:
  - Database staat op november1

Afhankelijk van:
  - november1


#### Mike1: CMS
##### Geschatte tijd 5 minuten
Leden:
  - Dennis
  - Julian
  - Mauritz

Functie:
  - Server met Content Management System (Wordpress)

Taken:
  - LAMP stack opstellen
  - Services aanzetten
  - Firewall configureren
  - Wordpress installeren en configureren

Testen:
  - Website moet toegankelijk zijn via webbrowser

Opmerkingen/problemen:
  - Database staat op november1

Afhankelijk van:
  - november1

#### Lima1: Fileserver
##### Geschatte tijd 10 minuten
Leden:
  - Keanu

Functie:
  - Samba fileserver die aanspreekbaar is met SMB/CIFS. Elke linux gebruiker heeft toegang tot zijn homefolder en kan inloggen met de inloggegevens van de AD server.

Taken:
  - Installatie Samba en andere benodigde packages
  - Configuratie Samba
  - Populate LDAP met Samba informatie

Testen:
  - Kan een client inloggen op de fileserver

Opmerkingen/problemen:

Afhankelijk van:
  - alfa1


#### Oscar1: Monitoring
##### Geschatte tijd 12 minuten
Leden:
  - Robin
  - Thomas

Functie:
  - Oscar is een motoring server die van elke server de performance zal in het oog houden net als de netwerk activiteit.

Taken:
  - motorisering over performances
  - motorisering over netwerk activiteit

Testen:
  - [testp-oscar1.md](https://github.com/HoGentTIN/p3ops-green/blob/master/docs/testplannen/testp-oscar1.md)

Opmerkingen/problemen:
  - Placeholder voor bijkomende informatie of mogelijke (gekende) problemen

Afhankelijk van:
  - geen


#### Zulu1: Firewall
##### Geschatte tijd 15 minuten
Leden:
  - Kenzie
  - Max

Functie:
  - Server met als OS PfSense die moet dienen als een firewall voor green.local domein.

Taken:
  - Server opstarten
  - SSH open zetten
  - Script runnen
  - Inloggen webgui

Testen:
  - [ ] script runnen

Opmerkingen/problemen:

Afhankelijk van:

## End-to-end testing
Leden:
  - Afhankelijk van server. Zie [bestand](taakverdeling-w13.md)
  - Leden staan op kaartjes Kanbanbord

### Scenario 1: Hoofdscenario
- Een client die verbind in het netwerk krijgt een IP adres toegewezen en kan volgende dingen realiseren:
- Surfen naar een adres op het internet vb. google.be
- Aanmelden op de fileserver en hierop werken (files bewerken, openen...)
- Een mail sturen vanuit green.local naar red.local

### Scenario 2: Een client kan zich ingloggen en kan een mail verzenden in het green.local netwerk een andere client ontvangt de mail

#### Stappen:
- Sluit een client pc0 aan.
- Sluit een client pc1 aan.
- Log in op het systeem met de gegevens gebruikersnaam `Rob` en passwoord `Test123`.
- Open de mailclient op pc0 en maak een nieuwe mail.
- Zend van pc0 een mail naar pc1 naar het email-adres `Ismail@green.local`.
- Log in op pc1 met de gegevens gebruikersnaam `Ismail` en passwoord `Test123`.
- Open de mailclient en ga naar ontvangen emails.

### Scenario 3: Een client kan de website bekijken op 172.16.0.36

#### Stappen:
- Sluit een client pc0 aan.
- Log in op het systeem met de gegevens gebruikersnaam `Thomas` en passwoord `Test123`.
- Open de webbrowser.
- Maak een zoekopdracht aan naar `172.16.0.36`.
- De Wordpress pagina is zichtbaar.

### Scenario 4: De gebruiker kan zijn persoonlijke mappen bekijken en heeft schrijfrechten

#### Stappen:
- Sluit een client pc0 aan.
- Log in op het systeem met de gegevens gebruikersnaam `robin` en passwoord `Test123`.
- Open de file explorer en ga naar `smb://GREEN/robin`. (GREEN = 172.16.0.18)
- Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- Test de leesrechten door de content van de home directory weer te geven `ls`.

### Scenario 5: De gebruiker kan de share van zijn gebruikersgroep bekijken en heeft schrijfrechten

#### Stappen:
- Sluit een client pc0 aan.
- Log in op het systeem met de gegevens gebruikersnaam `ismail` en passwoord `Test123`.
- Open de file explorer en ga naar `smb://GREEN/itadministra`. (GREEN = 172.16.0.18)
- Test de schrijfrechten door het aanmaken van een directory `mkdir testDir`.
- Test de leesrechten door de content van de share weer te geven `ls`.

### Scenario 6: Er kan van green.local een mail verzonden en ontvangen worden van red.local

#### Stappen:
- Sluit een client pc0 aan.
- Sluit een windows client aan op red.local.
- Log in op het systeem met de gegevens gebruikersnaam `Lennert` en passwoord `Test123`.
- Open de mailclient op pc0 en maak een nieuwe mail.
- Zend van pc0 een email naar `GEBRUIKER@red.local`.
- Log in op een windows machine en kijk of de mail ontvangen is.

### Scenario 7: De Mariadb database kan worden gebruikt voor wordpress

#### Stappen:
- Sluit een client pc0 aan.
- maak een zoekopdracht naar 172.16.0.36/wordpress
- vul de gegevens in zoals gewenst
- kies de database wp_mike1 als database
- indien nodig log in met username 'mike1' en passwoord 'mike1'
- launch de website en bekijk of het werkt
### Scenario 8: De Mariadb database kan worden gebruikt voor drupal

#### Stappen:
- Sluit een client pc0 aan.
- maak een zoekopdracht naar 172.16.0.7/drupal7/install.php
- vul de gegevens in zoals gewenst
- kies de database dp_echo1 als database
- surf naar 172.16.0.7/drupal7
- indien nodig log in met username 'echo1' en passwoord 'echo1'
- bekijk of de website is gelaunched
### Scenario 9: Een client die niet behoort tot green.local/red.local mag niet aan de servers geraken.
- Er is een client aangesloten langs de buiten zijde van het netwerk.
- De client mag niet aan de servers van green.local geraken.
- De client kan wel een mail sturen naar een client in het netwerk

### Scenario 10: De clients zijn correct geïnstalleerd met de papa server.
- Men kan inloggen op een pc
- Deze heeft een correcte default gateway en dns server
- Mailclient is correct geïnstalleerd

### Scenario 11: Een onbekende computer kan worden aangesloten op het netwerk en ontvangt een IP.
- Verbind een computer met het netwerk.
- Laat automatisch ip en DNS toewijzen door kilo1.
- Het systeem krijgt een ip tussen `172.16.1.8-172.16.1.72`
- De DNS staat op `172.16.0.40`

### Scenario 12: Een bekende computer kan worden aangesloten op het netwerk en ontvangt een IP.
- Verbind een computer met het netwerk.
- Laat automatisch ip en DNS toewijzen door kilo1.
- Het systeem krijgt een ip tussen `172.16.1.3-172.16.1.7`
- De DNS staat op `172.16.0.40`
