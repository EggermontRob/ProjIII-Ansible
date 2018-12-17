# Handleiding van de variabelen voor de forwarding DNS (Mbv bertvv.dnsmasq)

## Toevoegen van de rol.

- In site.yml wordt volgende code toegevoegd , dit zorgt ervoor dat een server quebec1 aangemaakt wordt waarop de rol bertvv.dnsmasq geïnstalleerd wordt. 

```
- hosts: quebec1
  vars:
  become: true
  roles:
    - bertvv.dnsmasq
  tasks:
```

- Door de configuratie in de group_vars , meerbepaald in het all.yml bestand wordt op iedere nieuwe server
verschillende packages geïnstalleerd. 

## Bespreking van de variabelen

In host_vars wordt een quebec1.yml file toegevoegd met volgende variabelen : 

- Zorgt ervoor dat de forwarding DNS werkt in het green.local domein.

```
dnsmasq_domain: 'green.local'
```

- Zorgt ervoor dat de service DNS toegelaten wordt door de firewall.

```
rhbase_firewall_allow_services:
  - dns
```

- Wanneer dit false is, betekent dit dat de lokale requests (van hostsystemen) ook nog steeds geforwarded worden. 

```
dnsmasq_domain_needed: 'false'
```

- Dit zijn de beschikbare addressen die gegeven worden aan de verschillende hostsystemen.
Startende bij 172.16.1.3 , eindigend bij 172.16.1.62.
Na 8 uur vervalt het ip adres bij een specifieke hostsysteem. Daarna moet hij opnieuw een request sturen.

```
dnsmasq_dhcp_ranges:
  - start_addr: '172.16.1.3'
    end_addr: '172.16.1.62'
    lease_time: '8h'
```

- Ip adres van de 'upstream' dns_servers. Dit zijn zowel de dns / backup dns servers van het domein green.local 
als van het domein red.local. (Lokaal). Wanneer er gebruik moet gemaakt worden van een domein naam buiten het 
lokale netwerk wordt het adres 193.191.158.15 gebruikt, wat het inside global adres is. 

```
dnsmasq_upstream_servers:

  - /green.local/172.16.0.4 #ns1.green.local
  - /green.local/172.16.0.5 #ns2.green.local

  - /red.local/172.18.0.34 #ns1.red.local
  - /red.local/172.18.0.35 #ns2.red.local

  - 193.191.158.15
```
