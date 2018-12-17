# Technische documentatie lima1: Samba File Server

## Inhoudstafel
- [Opdracht](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#opdracht)
- [Benodigdheden](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#benodigdheden)
- [Handleiding](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#handleiding)
    - [Ansible](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#ansible)
        - [Rh-base](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#rh-base)
        - [Hosts](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#hosts)
        - [Samba](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#samba)
    - [Script](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#script)
- [Hoe start je de fileserver op](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.old.md#Hoe-start-je-de-fileserver-op)

## Opdracht
Een interne file-server die aanspreekbaar is met SMB/CIFS. Deze file server is geïntegreerd in de directory structuur gedefinieerd door alfa1 en voorziet elke Linux-gebruiker van een home folder, enkel toegankelijk voor de gebruiker zelf. Wanneer een gebruiker inlogt op een werkstation, is die home folder meteen zichtbaar.

## Benodigdheden
* Vagrant
* Ansible
* Virtualbox

## Handleiding

### Ansible
Voor de Samba fileserver gebruiken we de ansible roles [rh-base](https://galaxy.ansible.com/bertvv/rh-base), [hosts](https://galaxy.ansible.com/bertvv/hosts) en [samba](https://galaxy.ansible.com/bertvv/samba) van [bertvv](https://galaxy.ansible.com/bertvv/).

Hier zullen we de ingestelde variablen bespreken.

#### Rh-base
Om te beginnen gaan we de rh-base role configureren.

```
# Dit zorgt ervoor dat de samba services door de firewall gelaten wordt
rhbase_firewall_allow_services:
    - samba
    
# Volgende packages zijn nodig voor de integratie tussen samba en ldap
rhbase_install_packages:
    - smbldap-tools
    - nss-pam-ldapd
    - nscd
    - openldap
    
# Maakt de benodigde user groups aan gedefinieerd door ldap
rhbase_user_groups:
    - itadministratie
    - verkoop
    - administratie
    - ontwikkeling
    - directie

# Maakt een paar test users aan en voegt ze toe aan een group.
rhbase_users:
    - name: alice
      groups:
        - verkoop
    - name: bob
      groups:
        - ontwikkeling
```

#### Hosts
Hier voegen we een entry toe aan `/etc/hosts` zodat alfa1 bereikt kan worden. Deze stap kan echter overgeslaan worden als de dns server werkt en aan staat maar kan geen kwaad om te beehouden. 
```
hosts_entries:
  - name: alfa1.green.local
    ip: 172.16.0.3
    aliases:
        - alfa1
        - ad
        - ad.green.local
```
#### Samba
Nu kan er begonnen worden aan de configuratie  van de eigenlijke samba server.
```
# Server informatie
samba_netbios_name: 'GREEN'
samba_server_string: 'Samba file server'
samba_workgroup: 'GREEN.LOCAL'

# Geen wins support nodig voor linux fileserver
samba_wins_support: false
# Deze variable moet op false staan zodat er geen nt error wordt weergegeven.
samba_mitigate_cve_2017_7494: false

# ldap link naar de AD server
samba_passdb_backend: 'ldapsam:"ldap://alfa1.green.local"'
# Samba security wordt achteraf nog ingesteld op domain maar moet eerst opstarten met user om errors te voorkomen.
samba_security: 'user'

# Andere samba variablen die niet door de samba role ondersteund worden kunnen in deze include config files mee gegeven worden. 
samba_global_include: lima-global-include.conf
samba_homes_include: lima-home-include.conf

# Maakt de samba shares aan voor alle groepen.
samba_shares:
  - name: itadministratie
    comment: 'IT Administratie share'
    group: itadministratie
    write_list: +itadministratie
    path: /srv/shares/itadministratie
  - name: verkoop
    comment: 'Verkoop share'
    group: verkoop
    write_list: +verkoop
    path: /srv/shares/verkoop
  - name: administratie
    comment: 'Administratie share'
    group: administratie
    write_list: +administratie
    path: /srv/shares/administratie
  - name: ontwikkeling
    comment: 'Ontwikkeling share'
    group: ontwikkeling
    write_list: +ontwikkeling
    path: /srv/shares/ontwikkeling
  - name: directie
    comment: 'Directie share'
    group: directie
    write_list: +directie
    path: /srv/shares/directie
```

`lima-global-include.conf`: dit bestand moet relatief tenopzichte van het ansible playbook in een map `templates` aangemaakt worden.
```
deadtime = 10
# SMB1 is verouderd en zou niet meer gebruikt mogen worden. Schakel dit uit door volgend variable toe te voegen.
;server min protocol = SMB2

#Logging
log level = 1
log file = /var/log/samba/log.%m
max log size = 5000
debug pid = yes
debug uid = yes
;syslog = 0
utmp = yes

domain logons = yes
os level = 64
logon path =
logon home =
logon drive = 
logon script = 

# Geen ssl
ldap ssl = no
;ldap admin dn = cn=ldapadmin,dc=green,dc=local
# dn voor ldap admin
ldap admin dn = uid=admin,ou=Administrators,ou=TopologyManagement,o=NetscapeRoot
ldap delete dn = no

## Sync UNIX password with Samba password
unix password sync = yes
pam password change = yes

#ldap suffixes
ldap suffix = dc=green,dc=local
ldap user suffix = ou=Users
ldap group suffix = ou=Groups
;ldap machine suffix = ou=Computers
ldap idmap suffix = ou=Idmap

# idmap range
idmap config * : range = 3000-7999
idmap config * : backend = ldap

ldapsam:trusted = yes
ldapsam:editposix = yes

#smbldap tools scripts
add user script = /usr/sbin/smbldap-useradd -m '%u' -t 1
rename user script = /usr/sbin/smbldap-usermod -r '%unew' '%uold'
delete user script = /usr/sbin/smbldap-userdel '%u'
set primary group script = /usr/sbin/smbldap-usermod -g '%g' '%u'
add group script = /usr/sbin/smbldap-groupadd -p '%g'
delete group script = /usr/sbin/smbldap-groupdel '%g'
add user to group script = /usr/sbin/smbldap-groupmod -m '%u' '%g'
delete user from group script = /usr/sbin/smbldap-groupmod -x '%u' '%g'
add machine script = /usr/sbin/smbldap-useradd -w '%u' -t 1

#Disables printers
disable spoolss = Yes
load printers = No
printcap name = /dev/null
printing = bsd
```

`lima-home-include.conf`: Dit moet ook toegevoegd worden in de map `templates`.
```
[homes]
browseable = No
comment = Home Directories
inherit acls = Yes
read only = No
valid users = %S %D%w%S
```
### Script
Nadat je `vagrant up lima1` hebt gedaan zal ansible normaal failen de eerste keer. Ga in lima1 met ssh: `vagrant ssh lima1`
Voer het volgende script uit met **root** access! `sudo /vagrant/Servers/lima1/setLdapConf.sh`

Het script legt uit met echo's wat er gebeurd, dit is [hier](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/setLdapConf.sh) te lezen

## Hoe start je de fileserver op
Om de Samba Fileserver op te zetten ga je over de volgende stappen moeten gaan:

### Start de DNS server: quebec1
- `vagrant up quebec1`

### Start de LDAP server: alfa1
- `vagrant up alfa1`

### Start de Samba fileserver: lima1 
- `vagrant up lima1`
- `vagrant ssh lima1`
- `sudo /vagrant/Servers/lima1/setLdapConf.sh`

