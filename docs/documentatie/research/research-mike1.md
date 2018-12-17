## Wordpress CMS system

Wordpress is één van de meest populaire cms systemen om een website mee te maken. Zowel beginners als ervaren gebruikers 
kunnen ermee overweg. Tevens hebben ze gemiddeld 8 updates per jaar, die eenvoudig geinstalleerd kunnen worden. 
Je hebt ook een premium versie, waarmee je gebruik kunt maken van extra functionaliteiten. Tevens worden alle websites 
gebouwd in responsive design, dus zijn goed te zien op zowel computers, tablets als op mobiele telefoons. Echter, 
Wordpress kan traag worden als er verschillende plug-ins worden gebruikt, of als er veel Wordpress websites op 1 server draaien. 
Ook heeft Wordpress veel onderhoud nodig vanwege de updates die jaarlijks uitgevoerd worden.


## Ansible file: mike1.yml

```yml

rhbase_firewall_allow_services:
  - http
  - https

dns_nameservers: 
  - "DNS1=172.16.0.40"

httpd_status_enable: true

wordpress_database: 'wp_mike1'
wordpress_user: 'mike1'
wordpress_password: 'mike1'
wordpress_database_host: '172.16.0.37'
wordpress_automatic_updates: true

```

## Ansible file: site.yml

```yml
- hosts: mike1
  vars:
  become: true
  roles:
    - bertvv.rh-base
    - bertvv.httpd
    - bertvv.wordpress
  tasks:
    - name: Setting hostname
      hostname:
        name: mike1.green.local
```

## Ansible file: vagrant-hosts.yml

```yml
- name: mike1
  hostname: mike1.green.local
  ip: 172.16.0.36
```
  
## Commando's om mike1 op te starten:

1. vagrant up mike1
2. ./scripts/role-deps.sh
3. vagrant provision 


## Requirements

- database server 
- database user
- database password

## Role variables

### Een woordje uitleg


| Task                                         | Command                                                                |
| :---                                         | :---                                                                   |
| rhbase_firewall_allow_services               | Lijst van de services die worden doorgetalten door de firewall         |
| dns_nameservers                              | Stelt het IP adres van de DNS server in                                |
| httpd_status_enable                          | True/false: Enable mod_status                                          |
| wordpress_database                           | De naam van de database waarvan wordpress gebruik zal maken            |
| wordpress_user                               | De naam van de database user                                           |
| wordpress_password                           | Het wachtwoord van de database user                                    |
| wordpress_database_host                      | Het IP adres van de database server                                    |
| wordpress_automatic_updates                  | True/false: De mogelijkheid om updates automatisch te laten uitvoeren  |

