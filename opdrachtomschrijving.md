# Opdrachtomschrijving - Linux
## Algemene requirements
* De gehele opstelling moet volledig geautomatiseerd zijn. Dat betekent dat op het moment van een productie-release het netwerk “from scratch” kan opgezet worden.
  * In het Linux-netwerk (zie verder) wordt gebruik gemaakt van het configuration mana- gement system Ansible
  * In het Windows-netwerk wordt gewerkt met hetzij PowerShell, Desired State Configu- ration of Ansible.
* Op elke server is een administrator-account voorzien voor beheer vanop afstand (Linux: via ssh; Windows: via WinRM/HTTPS).
* Elke component in het netwerk stuurt informatie over de eigen werking door naar het monitoringsysteem.
* Als testomgeving kan je VirtualBox met Vagrant gebruiken, maar de productie-omgeving moet een ander platform zijn. Gebruik bv. KVM-QEMU (Linux), Hyper-V (Windows), Docker (beide), OpenNebula, ...
* Als hostsystemen voor de productie-omgeving kan gebruik gemaakt worden van de oude klaspc’s (Dell Optiplex 760). Zorg dat die tijdig klaar zijn om gebruikt te kunnen worden!
* Optioneel: implementeer IPv6 binnen het eigen netwerk.
## Domeinen
Dit zijn de domeinnamen en toegewezen IP-blokken, per team:
* green.local 172.16.0.0/16 (Linux)
* red.local 172.18.0.0/16 (Windows)
Het domein green.local is volledig op Linux gebaseerd en red.local is een volledig Windows domein.  

Opgelet: Bovenvermelde Net-ID’s moeten nog verder verdeeld worden over de verschillende VLANs m.b.v. VLSM. De routering tussen de VLANs wordt uitgevoerd met statische routering.

Elk domein heeft vier switches en 5 VLANs :
* **2 L2-switchen:** Verbinden alle computersystemen binnen een VLAN.
* **2 L3-switchen:** Zorgen voor inter-VLAN verbindingen
* **VLAN 20, 200:** interne clients.
  * Private, dynamische IP-adressen (via DHCP)
  * Toegang tot de publieke servers van de andere domeinen.
* **VLAN 30, 300:** interne servers.
  * Vaste IP adressen.
  * Enkel bereikbaar voor hosts van het eigen domein.
* **VLAN 40,400:** publiek toegankelijke servers
  * Vaste IP adressen
  * Bereikbaar voor interne clients én voor clients van andere domeinen
* **VLAN 60,600:** Verbinding naar de PFSense Firewall.
* **VLAN 70, 700:** Verbinding naar het router netwerk en de buitenwereld.
## Routers en switches 
Alle routers zijn met elkaar verbonden met seriële kabels of UTP-kabels en maken gebruik van een dynamisch routeringsalgoritme. Doorverbinden met het Internet wordt voorzien via de PFSense firewall.  

ACLs op de routers en/of switchen beperken het binnenkomende verkeer van andere domeinen tot de publieke servers en de protocollen die op deze servers gebruikt worden.


Test vooraf de werking van deze opstelling uit in PacketTracer. Automatiseer het opzetten van de fysieke apparatuur aan de hand van scripts, of met een configuration management system1.

Router4, die een verbinding vormt tussen beide netwerken en het Internet is een gedeelde verant- woordelijkheid van beide teams.
## Servers
### alfa1
een domeinserver voor green.local voor gecentraliseerd beheer van gebruikers. Er zijn twee mogelijke pistes om dit te realiseren. Enerzijds via een LDAP-server (OpenLDAP, 389 Directory Server), anderzijds via een Linux-versie van de Active Directory Domain Controller (Samba 4). De verantwoordelijke kiest zelf welk platform gebruikt wordt.

Client-pc’s hebben geen eigen gebruikers, authenticatie gebeurt telkens via de domeinserver.

Maak onderstaande afdelingen (groepen) aan.
* IT Administratie
* Verkoop
* Administratie
* Ontwikkeling
* Directie

Maak een duidelijk verschil tussen gebruikers, computers en groepen. Voeg enkele gebruikers en minstens 5 werkstations toe (één in IT-Administratie, één in Ontwikkeling, één in Verkoop, één in Administratie en één in Directie).
### bravo1
Authoritative-only DNS server voor green.local, gebaseerd op BIND. DNS-requests voor andere domeinen worden NIET beantwoord. De buitenwereld kent deze server als “ns1”
### charlie1
Een “slave DNS” server die zelf geen zonebestanden bevat, maar synchroniseert met bravo1. De buitenwereld kent deze server als “ns2”
### delta1
Een mailserver (gebaseerd op Postfix) met SMTP en IMAP. Het moet mogelijk zijn mails te versturen en te ontvangen tussen de twee domeinen. Gebruikers in de directory server hebben ook een mailbox. Deze mailserver past ook anti-spam en anti-virus technieken toe.
### echo1
een publiek toegankelijke webserver met HTTP/HTTPS en voorzieningen voor dynamische we- bapplicaties (LAMP stack, of variant daarop) en Drupal. Het database-deel van de webapplicatie wordt uitbesteed aan november1. Je kan naar deze webserver surfen met het “www” voorvoegsel (vb. https://www.green.local/) vanop elke host in alle domeinen.
### kilo1
Een DHCP-server voor de interne clients. Gekende werkstations krijgen een IP-adres gereserveerd op MAC-adres.  
Hosts die booten over het netwerk (PXEBoot), worden doorverwezen naar de PXEBoot-server, papa1.
### lima1
Een interne file-server die aanspreekbaar is met SMB/CIFS. Deze file server is geïntegreerd in de directory structuur gedefinieerd door alfa1 en voorziet elke Linux-gebruiker van een home folder, enkel toegankelijk voor de gebruiker zelf. Wanneer een gebruiker inlogt op een werkstation, is die home folder meteen zichtbaar.
### mike1

Een content management system naar keuze voor intern gebruik. Mogelijke voorbeelden van een CMS zijn Wordpress, Drupal, Joomla, Mediawiki,...  
Het database gedeelte van deze CMS server staat eveneens op de database server november1.  
Deze server is enkel toegankelijk voor interne gebruikers van het domein green.local.
### november1
Een MariaDB database-server voor intern gebruik. Bevat al minstens de databases voor servers echo1 en mike1. De database-admins besteden bijzondere zorg aan performantie en high availability.  
### oscar1   
Een monitoringsysteem dat de toestand van het gehele netwerk + services kan visualiseren. Het specifieke systeem kunnen jullie zelf kiezen: Elastic Stack, Collectd, Sensu, . . . Overleg hierover met jullie begeleider.  
Afhankelijk van het type apparaat worden minstens volgende parameters opgevolgd:
* Cisco routers en switches (via SNMP):
  * CPU-gebruik
  * Geheugengebruik
  * Inkomend verkeer op alle netwerkpoorten
  * Uitgaand verkeer op alle netwerkpoorten
* Linux servers (zowel fysieke hosts als VMs):
  * CPU-gebruik
  * Geheugengebruik
  * Toestand van de harde schij(f)(ven)
  * Toestand van de specifieke service die op de machine draait (bv. metrieken over databasequeries, HTTP-requests, DNS-requests, enz.)
* Werkstations
  * CPU-gebruik
  * Geheugengebruik
  * Toestand harde schij(f)(ven)
  * Gebruikerslogins  
    
De resultaten zijn raadpleegbaar via een dashboard dat ook op oscar1 draait, via url https://mon. green.local/. Sommige monitoringsystemen hebben een ingebouwd systeem voor visualisatie (bv. Kibana voor Elastic Stack), er bestaan ook afzonderlijke tools (bv. Grafana of Graphite).
### papa1

Een PXEBoot-server die toelaat om hosts over het netwerk te installeren. Voorzie via een menu twee mogelijkheden: server of werkstation.

Een server wordt geïnstalleerd met de laatste versie van CentOS, en is via Kickstarter automa- tisch voorgeconfigureerd om in het netwerk opgenomen te worden (bv. administrator-gebruiker, package-installatie, configuratie updates). Het systeem kan dan verder geconfigureerd worden via configuration management en stuurt ook meteen informatie over de werking door naar het monitoringsysteem.

Een werkstation wordt geïnstalleerd met Fedora Workstation, dat voorgeconfigureerd werd via Kickstarter met typische software (webbrowser, Office, Mailclient, PDF-viewer, enz.). Na installatie kan het werkstation meteen gebruikt worden op het netwerk (bv. gebruikerslogin, email, toegang netwerkshares, aanvaarden certificaten webservers, enz.).
### quebec1
Een forwarding DNS-server voor werkstations. DNS-requests voor green.local worden geforward naar ns[12].green.local; DNS-requests voor red.be worden geforward naar ns[12].red.local; alle andere requests gaan naar een geschikte DNS-server die externe namen kan resolven (bv. die van HoGent). Gebruik hiervoor Dnsmasq.

## Werkstations VLAN 20
Configureer op zijn minst 5 client pc’s waar een gebruiker kan op inloggen, e-mail kan lezen, en van waar de publieke en private services van het eigen en publieke services van andere domeinen kunnen getest worden.

Elk van deze PC’s is lid van één van gespecifieerde afdelingen in de directorystructuur (AD voor Windows en OpenLDAP voor Linux).

Zorg ervoor dat elke afdeling minimaal met 1 PC voorzien is.
## Firewalls
* **zulu1** bevindt zich tussen VLANs 60 en 70.
* **zulu2** bevindt zich tussen VLANs 600 en 700.
* OS: De meest recente stabiele versie van PFSense.
* Deze Firewall heeft NAT uitgeschakeld! NAT is actief op de router Router0.
* Configureer deze firewall zodanig dat enkel die poorten openstaan die echt nodig zijn binnen uw netwerk
* Configureer deze firewall zodanig dat je vanuit elk subnet van je netwerk/LAN (zowel de
VLANs als de router subnets) kan communiceren met het internet.
## Tools voor inter gebruik
Naast het opleveren van netwerkinfrastructuur naar klanten toe, bestaat een deel van het werk van een systeembeheerder ook uit het optimaliseren van het “productieproces”. Voorzie dus dat een deel van de tijd hier aan besteed wordt, en dat dit zichtbaar is in het kanban-bord.

Voordelen:
* Opzetten virtualisatie-infrastructuur voor de productie-omgeving;
* Automatiseren van tests, o.a.:
  * Statische analyse van code op stijl en vaak voorkomende fouten (“linting”);
  * Functionele tests op individuele componenten;
  * Integratietests;
* Uitvoeren van geautomatiseerde tests na elke commit of merge;
* Automatiseren van genereren technische documentatie in de vorm van een e-book of website
(zoals readthedocs.io);
* Schrijven of aanpassen van tools/scripts voor gebruik binnen het project;
* enz.
