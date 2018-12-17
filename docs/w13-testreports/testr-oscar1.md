# Testrapport Oscar 1


## Alle te testen onderdelen in secties onderverdeeld: 

### Aanwezigheid van Deliverables

| Vereist       | Aanwezig      | Commentaar |
| ------------- |:-------------:| ---------- |
| DNS Servers bravo1 en charlie1 moeten bereikbaar zijn |x |   |
| Forwarding DNS Server moet bereikbaar zijn |x |   |

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
- [x] Nagaan of alle services draaien
  * Verwacht resultaat: 
    * Services Kibana, Elasticsearch, Packetbeat en Metricbeat werken en zijn enabled
- [x] Nagaan of je een overzicht krijgt van de servers
  * Verwacht resultaat: 
    * http://172.16.0.38:5601 is beschikbaar
    * Mooi overzicht van ALLE servers op de Kibana pagina
    * Mooi overzicht over het netwerkverkeer op ALLE servers
