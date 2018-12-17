# Draaiboek WEEK 7

Dit draaiboek zal de flow proberen beschrijven van de werken/taken die moeten gebeuren tijdens de proof-of-concept van week 7.
## Algemene afspraken

Iedereen heeft recht op pauze, snel eens naar toilet gaan is uiteraard geen enkel probleem maar bij voorkeur toch drinken/eten meebrengen naar het lokaal, je kan eventueel onder de middag even naar buiten maar het is natuurlijk aangenamer en makkelijker vooor de uitvoering van het project dat je toch in de buurt blijft. Indien je onder de middag toch het lokaal verlaat gebeurt dit onder volgende voorwaarden:
- Niet iedereen gaat tegelijk weg, verdeel dit (pauze van 12:00 - 13:15)
- Iedereen blijft bereikbaar
- We zijn een team, de opdracht is NIET gedaan als jouw deeltje af is, iedereen kan bijdragen en helpen indien er moet worden

## Kanbanbord week 7
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

### 8:45: Start!
---
#### 1. Netwerk configuratie
Leden:
  - Michiel

Functie:
  - Zorgen voor een werken netwerk, zowel binnen het linux-domain als naar het windows-domain

Taken:
  - Kabels
  - Router configuraties
  - Switch configuraties

Testen:
  - [ ] Config files switch ingeladen
  - [ ] Inter-VLAN routing testen adhv pings, hierna routers pingen en hierna Windows-domein

Opmerkingen/problemen:
  - Uiteindelijke doorgang naar internet is nog niet geconfigureerd? Welk ip adres krijgt de laatste poort richting internet (DHCP via school?), zoja waarschijnlijk werken met NAT-overloading
  - Security (passwoorden, port-security...) zal nog niet geïmplementeerd worden, eerst ervoor zorgen dat iedereen gewoon connectie heeft


#### 2. Opstart Esxi
Leden:
  - Rob

Functie:
  - Terugzetten van de snapshots
  - Deployment van de VMs op de Server via KVM

Testen:
  - [ ] VMs zijn aanwezig op de server

Opmerkingen/problemen:


### 3. Servers
#### Quebec1: Forwarding DNS
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
  - Momenteel geen.

Afhankelijk van:
  - Bij het opzoeken van lokale requests moeten de DNS servers bravo1 & charlie1 up & running zijn.


#### Oscar1
Leden:
  - Robin
  - Thomas

Functie:
  - Oscar is een motorisering server die van elke server de performance zal in het oog houden net als de netwerk activiteit.

Taken:
  - motorisering over performances
  - motorisering over netwerk activiteit

Testen:
  - [testplan](https://github.com/HoGentTIN/p3ops-green/blob/master/docs/testplannen/testp-oscar1.md)

Opmerkingen/problemen:
  - Placeholder voor bijkomende informatie of mogelijke (gekende) problemen

Afhankelijk van:
  - geen

## 9:15
---
#### Bravo1 & Charlie1: DNS
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




## 10:00
---
#### Alfa1: 389 AD
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


#### Kilo1: DHCP
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
  - Er kunnen problemen opduiken als we een adres willen geven aan de client die zich in een ander subnet bevindt, dit mag normaal niet gebeuren.

Afhankelijk van:
  - Router(multilayerswitch) van VLAN 30 die de DHCP-Requests kan forwarden naar vlan 20 (clients).
  - Verder geen afhankelijkheden.


#### Papa1: PXE
Leden:  
  - Thibo

Functie:  
  - PXEServer die er moet voor zorgen dat werkstations kunnen booten vanop het netwerk.
    Ervoor zorgen dat werkstations:
      - een OS krijgen (CentOS of Fedora 28)
      - kunnen aanmelden
      - applicaties kunnen gebruiken
      - toegang hebben tot de netwerkshares
  - Beschrijving van wat jouw deelopdracht zou moeten realiseren

Taken:  
  - Uitvoeren van Ansible taken uit site.yml  
  - 2 pc's opzetten met VirtualBox die ieder een OS testen  
  - ...

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
  - wanneer een werkstation niet naar het internet kan, kunnen de volgende zaken niet uitgevoerd worden:
    - verbinding maken met online mirrors (OS repositories)
    - packages downloaden
  - er is geen zekerheid dat een account uit Active Directory zal kunnen aanmelden (er is een testuser voorzien)
  - [ ] ...

 Opmerkingen/problemen:  
  - Placeholder voor bijkomende informatie of mogelijke (gekende) problemen

 Afhankelijk van:  
  - kilo1 (DHCP)
  - Placeholder voor afhankelijkheden

#### Delta1: Mail
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
  - geen

Afhankelijk van:
  - /


12:00
---

#### Lima1: Fileserver
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


#### Echo1: Webserver
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


#### Zulu1: Firewall
Leden:
  - Kenzie
  - Max

Functie:
  - Server met als OS PfSense die moet dienen als een firewall voor green.local domein.

Taken:
  - (Via USB configuratie recoveren?)
  - PfSense OS installeren.
  - SSH enablen
  - LAN-Interface instellen
  - Web Gui bereiken over LAN-interface
  - Config proberen resotren
  - Manuele configuratie

Testen:
  - [ ] Uitgaant verkeer
  - [ ] Binnekomend verkeer

Opmerkingen/problemen:
  - Recovery over USB
  - Recovery via WebGui

Afhankelijk van:
  - Netwerk

15:00
---

## End-to-end testing
Leden:
  - Jens
  - Artuur
  - Jarne

  Testen:
  ### Scenario 1
  - [ ] Een client kan zich ingloggen en kan een mail verzenden in het green.local netwerk een andere client ontvangt de mail.
  #### afhankelijkheden:
  * Alfa1
  * Bravo1/Charlie1
  * Delta1
  * Quebec1
  * Kilo1
  * Papa1
  * Netwerk
  
  ### Scenario 2
  - [ ] Een client kan de website bekijken op `172.16.0.39`
  #### afhankelijkheden:
  * Alfa1
  * Bravo1/Charlie1
  * Quebec1
  * Papa1
  * Kilo1
  * Echo1
  * November1
  * Netwerk
  
  ### Scenario 3
  - [ ] De gebruiker kan zijn persoonlijke mappen bekijken.
  #### afhankelijkheden:
  * Alfa1
  * Bravo1/Charlie1
  * Quebec1
  * Papa1
  * Kilo1
  * Lima1
  * Netwerk
  
  ### Scenario 4
  - [ ] Er kan van green.local een mail verzonden en ontvangen worden van red.local
  #### afhankelijkheden:
  * Alfa1
  * Bravo1/Charlie1
  * Delta1
  * Quebec1
  * Kilo1
  * Papa1
  * Zulu1
  * Netwerk
  * De omgeving van red.local
