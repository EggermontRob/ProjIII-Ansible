# Technische documentatie lima1: Samba File Server

## Inhoudstafel
- [Opdracht](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#opdracht)
- [Benodigdheden](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#benodigdheden)
- [Handleiding](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#handleiding)
    - [Ansible](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#ansible)
        - [Rh-base](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#rh-base)
        - [Hosts](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#hosts)
        - [Samba](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#samba)
    - [Script](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#script)
- [Hoe start je de fileserver op](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/lima1/Technische%20documentatie.md#Hoe-start-je-de-fileserver-op)

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

# Maakt de test users aan en voegt ze toe aan een group. Het wachtwoord voor alle gebruikers is 'Test123'
rhbase_users:
  - name: keanu
    groups:
      - wheel
      - root
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: ismail
    groups:
      - itadministratie
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: itadministratieuser
    groups:
      - itadministratie
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: lennert
    groups:
      - verkoop
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: verkoopuser
    groups:
      - verkoop
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: rob
    groups:
      - administratie
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: administratieuser
    groups:
      - administratie
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: robin
    groups:
      - ontwikkeling
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: ontwikkelinguser
    groups:
      - ontwikkeling
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: thomas
    groups:
      - directie
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
  - name: directieuser
    groups:
      - directie
    password: '$6$glOruZ2Pc/EiQVtH$Wa.ndyK0JLUHrYYQ8kWOZo5bpCW4ErZ0M7z0n667g1A8fqbJh4yckrdv90uQEGwiPqF2RM2kJNfs3uS/wrjoG1' #hash for "Test123"
```

#### Samba
Nu kan er begonnen worden aan de configuratie  van de eigenlijke samba server.
```
# Server informatie
samba_netbios_name: 'GREEN'
samba_server_string: 'Samba file server'
samba_workgroup: 'GREEN.LOCAL'

#Zorgt dat gebruikers een home directory hebben
samba_load_homes: true

# Maakt de samba users aan en geeft hun een wachtwoord
samba_users:
  - name: ismail
    password: Test123
  - name: lennert
    password: Test123
  - name: rob
    password: Test123
  - name: robin
    password: Test123
  - name: thomas
    password: Test123
  - name: itadministratieuser
    password: Test123
  - name: verkoopuser
    password: Test123
  - name: administratieuser
    password: Test123
  - name: ontwikkelinguser
    password: Test123
  - name: directieuser
    password: Test123

# Maakt de samba shares aan voor alle groepen.
samba_shares:
  - name: itadministra
    comment: 'IT Administratie share'
    browseable: yes
    group: itadministratie
    write_list: +itadministratie
    valid_users: +itadministratie
  - name: verkoop
    comment: 'Verkoop share'
    browseable: yes
    group: verkoop
    write_list: +verkoop
    valid_users: +verkoop
  - name: administrat
    comment: 'Administratie share'
    browseable: yes
    group: administratie
    write_list: +administratie
    valid_users: +administratie
  - name: ontwikkeling
    comment: 'ontwikkeling share'
    browseable: yes
    group: ontwikkeling
    write_list: +ontwikkeling
    valid_users: +ontwikkeling
  - name: directie
    comment: 'directie share'
    browseable: yes
    group: directie
    write_list: +directie
    valid_users: +directie
```

## Hoe start je de fileserver op
Om de Samba Fileserver op te zetten ga je over de volgende stappen moeten gaan:

### Start de DNS server: quebec1
- `vagrant up quebec1`

### Start de Samba fileserver: lima1 
- `vagrant up lima1`

## Testing
- Volg het testplan `p3ops-green/docs/testplannen/testp-lima1.md` om de fileserver te testen.

## Gebruik
Enkele nuttige commando's om de fileserver te gebruiken:
- Log in als `user` op zijn homedirectory: `smbclient //GREEN/user -Uuser` 
- Log in als `user` op de share `share`: `smbclient //GREEN/share -Uuser`
Eenmaal ingelogd:
- Plaats een bestand op de fileserver: `put <filename>`
- Download een bestand van de fileserver: `get <filename> [localname]` 
