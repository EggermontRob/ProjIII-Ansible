# Documentatie: Hoe alfa1 opzetten

_Dit is een tijdelijke manier om de alfa1 server te configureren.
Indien vragen of problemen contacteer Ismail El Kaddouri of Lennert Mertens._


# ABANDONED
## Volg deze stappen
1. Open je 'Terminal' en open volgende map: `./Servers/alfa1/testomgeving`
- Deze map bevat alle bestanden voor het opzetten van alfa1 server
2. Doorloop volgende stappen om de LDAP server op te zetten
- `vagrant up`: installeert en configureert de standaard-instellingen
- Na de installatie zeker: `vagrant reload` (Zorgt dat shared folders opnieuw worden gemount)
- Connecteer met de vagrant-box: `vagrant ssh`
- Wordt root user: `sudo -i`
- cd naar de map `/data` : `cd /data`
- Voer het ldap installatie-script uit: `./ldap-install.sh` (Zeker als root uitvoeren)

3. Als alles goed werd uitgevoerd, dan is de machine nu klaar voor gebruik.

## Fouten in opzetten van de omgeving?
Voer vanuit de map `./Servers/alfa1/testomgeving` vanop uw host-systeem het commando `vagrant destroy` uit en start opnieuw.

## Gebruikers toevoegen


# Configuratie via bash scripts

##Opzetten omgeving en initialisatie omgeving

'cd Servers/alfa1/testomgeving'
'vagrant up'
'vagrant reload'
'ssh -X vagrant@alfa1'
'cd /data'
'sudo ./ldap.sh'
'sudo ./config.sh' #Dit script nooit meer dan 1 keer uitvoeren.

## 389-DS opstarten
als standaarduser
'389-console'
** Credentials **
user: admin
password: ldapadmin
server: http://localhost:9830

## 389-DS raadplegen
- Gebruikers en groepen
  -> Server group -> Directory Server -> ->Directory -> expand green
