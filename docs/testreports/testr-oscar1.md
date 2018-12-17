# Testrapport Oscar 1

## Alle te testen onderdelen in secties onderverdeeld: 

### Aanwezigheid van Deliverables

| Vereist       | Aanwezig      | Commentaar |
| ------------- |:-------------:| ---------- |
| DNS Servers bravo1 en charlie1 moeten bereikbaar zijn | x|   |
| Forwarding DNS Server moet bereikbaar zijn |x |   |

Alle servers zijn bereikbaar.

### Provisioning van de server
- [x] Provision server met ansible / vagrant
- [x] Er is geen gebruikerstussenkomst tijdens de installatie
- [x] De installatie verloopt zonder errors
- [x] Er kan verbinding worden gemaakt via een VM


## Werking van de server
### Stappen voor het testen
- [x] Nagaan van de IP addressseringen: `ip a`
  * Verwacht resultaat: 
    * 172.16.0.38 255.255.255.224 172.16.0.1 (default gateway)
````console
[root@oscar1 ~]# ip a | grep inet
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
    inet 172.16.0.38/27 brd 172.16.0.63 scope global noprefixroute ens192
    inet6 fe80::20c:29ff:fea3:e452/64 scope link 
    inet 172.22.10.131/16 brd 172.22.255.255 scope global noprefixroute dynamic ens224
    inet6 fe80::20c:29ff:fea3:e45c/64 scope link
````

- [ ] Nagaan of alle services draaien
  * Verwacht resultaat: 
    * Services Kibana, Elasticsearch, Packetbeat en Metricbeat werken en zijn enabled
````console
● kibana.service - Kibana
   Loaded: loaded (/etc/systemd/system/kibana.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-12-10 10:19:35 CET; 1h 52min ago
 Main PID: 6269 (node)
   CGroup: /system.slice/kibana.service

````
````
[root@oscar1 ~]# systemctl status elasticsearch
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-12-10 10:19:36 CET; 1h 52min ago
     Docs: http://www.elastic.co
 Main PID: 6342 (java)

````

````
● packetbeat.service - Packetbeat analyzes network traffic and sends the data to Elasticsearch.
   Loaded: loaded (/usr/lib/systemd/system/packetbeat.service; enabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: https://www.elastic.co/products/beats/packetbeat

````

````
● metricbeat.service - Metricbeat is a lightweight shipper for metrics.
   Loaded: loaded (/usr/lib/systemd/system/metricbeat.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-12-10 10:20:19 CET; 1h 53min ago
     Docs: https://www.elastic.co/products/beats/metricbeat
 Main PID: 6583 (metricbeat)

````

**OPMERKING: PACKETBEAT IS DISABLED**
- [x] Nagaan of je een overzicht krijgt van de servers
  * Verwacht resultaat: 
    * http://172.16.0.38:5601 is beschikbaar
    * Mooi overzicht van ALLE servers op de Kibana pagina
    * Mooi overzicht over het netwerkverkeer op ALLE servers