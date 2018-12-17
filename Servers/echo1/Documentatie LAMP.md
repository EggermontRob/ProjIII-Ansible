# LAMP Documentatie

## Wat is LAMP?

LAMP is een acroniem voor een set van gratis vrije softwarepakketten, die vaak samen gebruikt worden om dynamische websites te draaien:

- Linux, het besturingssysteem;
- Apache HTTP Server, de webserver;
- MariaDB of MySQL, het databasemanagementsysteem (of databaseserver); of in plaats daarvan PostgreSQL (LAPP) of SQLite (LASP)
- P voor PHP, Perl, en/of Python, de programmeertaal

## Uitwerking

1. Automatisering van de installatie met Ansible 

## Ansible roles
- [bertvv.rh-base](https://github.com/bertvv/ansible-role-rh-base)
- [bertvv.httpd](https://github.com/LennertMertens/ansible-role-httpd)

## Uitleg echo1.yml bestand met variabelen

### Firewall: 
Volgende variabelen zorgen ervoor dat de gewenste services worden toegelaten door de firewall.
```yml
rhbase_firewall_allow_services:
  - http
  - https
```


Volgende variabelen zorgen voor de gewenste instellingen van de LAMP server.
```yaml
httpd_status_enable: true

drupal_database: 'drupal'
drupal_username: 'drupal'
drupal_password: 'drupal'
drupal_database_host: '172.16.0.37'
```
