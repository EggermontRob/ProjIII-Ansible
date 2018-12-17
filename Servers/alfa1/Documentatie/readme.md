# LDAP Documentatie

## Wat is LDAP?

LDAP is te vergelijken met een soort van databank die gebruikersgegevens opslaat in een boomstructuur. Om informatie te raadplegen is het mogelijk om queries op deze stuctuur uit te voeren.

De boomstructuur bestaat uit verschillende onderdelen:

- De wortel van de boom bevat `dc=green`, `dc=local`, hierop zoeken geeft alle items terug die in de boom aanwezig zijn.
- De wortel bevat ook kinderen, deze kinderen kunnen verschillende OU's zijn, bv `ou=itadministratie`. 
- De boom bevat ook bladeren, deze bladeren kunnen de verschillende gebruikers zijn.

Om queries uit te voeren op een LDAP server kan je gebruikmaken van enerzijds de tool `ldapsearch` die wordt meegeleverd met de package `openldap-clients` of anderzijds de Admin Console (GUI). 

### Mogelijke queries

| Betekenis | Query |
| :-------- | :---- |
| Geef alle entiteiten weer in de boom | `ldapsearch -x -b "dc=green,dc=local"`                    |
| Zoek alle entiteiten binnen een OU   | `ldapsearch -x -b "OU=Users,dc=green,dc=local"`           |
| Zoek een specifieke entiteit         | `ldapsearch -x -b "uid=lennert,OU=Users,dc=green,dc=local"`|
| Testen van een gebruiker (hier admin)| `ldapsearch -x -b "dc=green,dc=local" -D "cn=Admin" -w ldapadmin` |

## Uitwerking

### 1/11/2018
1. Automatisering van de installatie met Ansible 
2. Toevoegen van gebruikers aan de hand van bash-script

## Ansible roles
- [bertvv.rh-base](https://github.com/bertvv/ansible-role-rh-base)
- [lennertmertens.ansible_role_389ds](https://github.com/LennertMertens/ansible-role-389ds)

**Note:** Deze role is gebaseerd op een role die al meer dan een jaar niet meer werd maintained, vertrekkende van die outdated role werd deze nieuwe role geschreven en aangepast in overeenstemming met wat we eerst hadden gescript na de manuele LDAP installatie.


## Uitleg alfa1.yml bestand met variabelen

### Firewall: 
Volgende variabelen zorgen ervoor dat de gewenste poorten worden toegelaten door de firewall.
```yml
rhbase_firewall_allow_ports:
  - 80/tcp
  - 389/tcp
  - 9830/tcp
  - 636/tcp
  - 3269/tcp
```

Naast de ports worden ook de netwerkkaarten toegelaten door de firewall.
```yaml
rhbase_firewall_interfaces:
  - enp0s3
  - enp0s8
```

Volgende variabelen zorgen voor de gewenste instellingen van de LDAP server. In commentaar worden deze variabelen verder uitgelegd
```yaml
# Hostname van de LDAP server
dirsrv_hostname: alfa1
# Fully Qualified Domain Name of the server
dirsrv_fqdn: alfa1.green.local
# dirsrv password
dirsrv_password: ldapadmin
# Admin account password
dirsrv_admin_password: ldapadmin
# Admin account
dirsrv_rootdn: "cn=admin"
# IP address of the LDAP server
dirsrv_ip: 172.16.0.3
```
