# Documentatie DHCP

## Server Details

- Naam: `kilo1`
- IP-adres: `172.16.0.34`
- Service: `DHCP`
- VLAN: `30`
- Verantwoordelijkheid: `Alex Devlies`

## Rollen

- [bertvv.rh-base](https://galaxy.ansible.com/bertvv/rh-base)
- [bertvv.dhcp](https://galaxy.ansible.com/bertvv/dhcp/)
- [tvandeveire.ekstack_metricbeat_packetbeat](https://galaxy.ansible.com/tvandeveire/ekstack_metricbeat_packetbeat) 
## Uitleg gebruikte variabelen

Het configuratiebestand `ansible/host_vars/kilo1.yml` bevat de nodige variabelen om een DHCP server automatisch op te zetten.
Hieronder verklaren we wat deze variabelen doen:

- **default lease time** en  **maximale lease time** stellen de lease time in seconden in.
  ```yaml
  dhcp_global_default_lease_time: 28800
  dhcp_global_max_lease_time: 43200
  ```

- Deze variabele stelt de **domeinnaam** in.
  ```yaml
  dhcp_global_domain_name: green.local
  ```

- Met de variabele `dhcp_global_next_server` geven we de PXE Boot server mee die gebruikt wordt door de clients.
  ```yaml
  dhcp_global_next_server: 172.16.0.39
  ```
- Met de variabele `dhcp_global_filename` geven we de file van de PXE Boot server mee die gebruikt wordt door de clients.
  ```yaml
  dhcp_global_filename: "pxelinux.0"
  ```

- `dhcp_global_domain_name_servers` bevat een **opsomming van de DNS-servers** van het green.local domein. Deze zijn Bravo1, Charlie1 en Quebec1.
  ```yaml
  dhcp_global_domain_name_servers:
    - 172.16.0.40
    - 172.16.0.4
    - 172.16.0.5
  ```

- `dhcp_global_routers` verwijst naar de default-gateway, de **router van VLAN 30**.
  ```yaml
  dhcp_global_routers: 172.16.0.33
  ```
- `dhcp_subnets` declareert een subnet voor de DHCP server voor nieuwe clients die later in het netwerk toegevoegd worden (de voorziene werkstations krijgen een IP op basis van hun MAC).
Met de variabele `ip` wordt IP van netwerk meegegeven, `netmask` het subnetmask en `booting` en `bootp` zijn beide allowed.
Hier geven we eerst het netwerk mee waar de DHCP-Server zich in bevind, hierin worden geen clients gedeployed. We hebben deze stap nodig om in de Task (site.yml) nog een extra blockinfile toe toe voegen, hieronder uitleg te vinden. Als laatste argument geven we nog eens de specifieke file mee waarvan de clients geboot moeten worden.
```yaml
dhcp_subnets:
   - ip: 172.16.0.32
     netmask: 255.255.255.224
     booting: allow
     bootp: allow
     filename: "pxelinux.0"
```

- **Deze oplossing (oplossing zonder task) is niet goed genoeg omdat het netwerk van de clients zich in een ander subnet bevind dan de DHCP server!!! ==> Vagrant provision kilo1 lukt niet omdat DHCP Deamon niet gestart kan worden.**

 Hiervoor is een oplossing gevonden: We moeten werken met een **shared netwerk** zodat de DHCP server kan communiceren met de clients die een ip moeten krijgen.
 De oplossing wordt doorgevoerd in `site.yml`, met behulp van [blockinfile](https://docs.ansible.com/ansible/2.7/modules/blockinfile_module.html).
 1. Hier voegen we een nieuwe `task` toe en noemen deze "Add lines to dhcpd config for client range".
 2. In `path` geven we de file mee waar het block met tekst/configuratie moet ingevoegd worden.
 3. `block` bevat alle info die nog extra moet meegegeven worden aan het configuratiebestand van dhcpd, namelijk:
    - Een block van `shared-network clients` om aan te geven dat het over een shared netwerk gaat.
    - declaratie van een netwerk `172.16.1.0` met subnet `255.255.255.192`
    - Dit bevat een range van IP's, een default gateway, een subnetmask en `bootp` & `booting` die allowed zijn.
    - Deze pool met adressen zal worden gebruikt door andere clients die later worden toegevoegd aan het netwerk. Opnieuw wordt de bootfile (`pxelinux.0`) meegegeven op het einde. 

 ```yaml
 - name: Add lines to dhcpd config for client range
   blockinfile:
     path: "/etc/dhcp/dhcpd.conf"
     block: |
       shared-network clients {
           subnet 172.16.1.0 netmask 255.255.255.192{
               range 172.16.1.8 172.16.1.62;
               option routers 172.16.1.1;
               option subnet-mask 255.255.255.192;
               allow bootp;
               allow booting;
               filename "pxelinux.0";
                }
         }
 ```

- Sommige clients krijgen een IP-adres op basis van hun MAC-adres. De range voor deze is van `172.16.1.3` tot en met `172.16.1.7`.
    - `name` is voor client te identificeren, `mac` om mac-adres mee te geven en `ip` om te zeggen welk ip de client moet ontvangen.
    - Het zijn enkel de 5 clients die al gekend zijn in het netwerk die een ip krijgen aan de hand van hun MAC. Zoals gezien kan worden is het eerste MAC address totaal verschillend van de andere adressen, dit komt omdat we hier een MAC adres hebben gebruikt van de PC van een Teamlid. Dit hebben we gedaan om zo in de fysieke omgeving te kunnen testen of deze PC wel het juiste IP-Adres krijgt als zijn MAC bekend is bij de DHCP-Server.

``` yaml 
dhcp_hosts:
   - name: WS0
     mac: 'A0:CE:C8:19:DD:30'
     ip: 172.16.1.3
   - name: WS1
     mac: '52:54:00:24:AB:6D'
     ip: 172.16.1.4
   - name: WS2
     mac: '52:54:00:C3:F4:A4'
     ip: 172.16.1.5
   - name: WS3
     mac: '52:54:00:18:C8:4B'
     ip: 172.16.1.6
   - name: WS4
     mac: '52:54:00:2C:22:49'
     ip: 172.16.1.7
   ```
- Er worden in de `site.yml` nog pre- en post-tasks toegevoegd.
  - De **pre-task stelt** op de fysieke server een hostnaam voor de DHCP-Server in: 
  ```
    pre_tasks:
      - name: Setting hostname
        hostname:
          name: kilo1.green.local
  ```
  - De gewone **Task** installeert syslinux op de server: 
  ```
    tasks:
      - name: Install syslinux
        yum:
          name: syslinux
          state: present
  ```
  - De **post-task** voeren allerlei taken uit. Deze worden duidelijk door hun naamgeving, hier is dus geen verdere uitleg nodig: 
  ```
    post_tasks:
      - name: Remove the NAT default gateway on ens224
        shell: nmcli con modify ens224 ipv4.never-default true
      - name: Configure default gateway on ens192
        shell: nmcli con modify "System ens192" ipv4.never-default false
      - name: Add default gateway
        shell: nmcli con modify "System ens192" ipv4.gateway 172.16.0.33
      - name: Restart network service
        systemd:
          name: network.service
          state: restarted
  ```
## Bronnen
- [Ansible rol DHCP van Bert Van Vreckem ](https://galaxy.ansible.com/bertvv/dhcp)
- [blockfile](https://docs.ansible.com/ansible/2.7/modules/blockinfile_module.html)
- [Uitleg manuele installatie DHCP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-dhcp-configuring-server)
- [Uitleg shared networks](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-dhcp-configuring-server.html)
---
