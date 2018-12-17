# Testrapport Delta 1


## Alle te testen onderdelen in secties onderverdeeld: 

### Aanwezigheid van Deliverables

| Vereist       | Aanwezig      | Commentaar |
| ------------- |:-------------:| ---------- |
| DNS Servers bravo1 en charlie1 moeten bereikbaar zijn | |   |
| Forwarding DNS Server moet bereikbaar zijn | |   |
| LDAP moet beschikbaar zijn (mailadressen via dovecot en postfix) | |   |
| 2 client systemen moeten beschikbaar zijn om de mailserver te testen | |   |

### Provisioning van de server
- [X] Provision server met ansible / vagrant
- [X] Er is geen gebruikerstussenkomst tijdens de installatie
- [X] De installatie verloopt zonder errors
- [X] Er kan verbinding worden gemaakt via een mail client

## Werking van de server
### Stappen voor het testen
- [X] Nagaan van de IP addressseringen: `ip a`
  * Verwacht resultaat: 
    * 172.16.0.6 255.255.255.224 172.16.0.1 (default gateway)
- [X] Nagaan of alle services draaien
  * Verwacht resultaat: 
    * Services Postfix, Dovecot, ClamAV en SpamAssasin werken en zijn enabled
- [X] Nagaan of de lokale DNS werkt
  * Verwacht resultaat:
    * Pingen naar andere servers binnen het netwerk is mogelijk via FQDN
- [x] Nagaan of de forwarding DNS werkt
  * Verwacht resultaat: 
    * Pingen naar het externe netwerk red.local is mogelijk
    * Pingen naar het externe adressen (zoals google.be, hln.be, ident-it.be, ...) is mogelijk
- [X] Nagaan of de client een mail kan sturen naar een andere client in het netwerk
  * Verwacht resultaat:
    * e-mails worden succesvol verzonden naar een andere client met een ander (intern) mailadres
- [X] Nagaan of de cleint een mail kan ontvangen naar een andere cleint in het netwerk`
  * Verwacht resultaat:
     * e-mails worden succesvol ontvangen vanuit een andere client met een ander (intern) mailadres
- [X] Nagaan of de client een mail kan sturen naar een andere client in buiten het netwerk (red.local)
  * Verwacht resultaat:
     * e-mails worden succesvol verzonden naar een andere client met een email adres van het domein red.local
- [x] Nagaan of de cleint een mail kan ontvangen naar een andere cleint in buiten het netwerk
  * Verwacht resultaat:
     * e-mails worden succesvol ontvangen vanuit een andere client een email adres van het domein red.local
- [X] Nagaan of alle gebrukers in het domein kunnen gebruik maken van hun e-mailadres van de vorm username@green.local
  * Verwacht resultaat:
    * Elke gebruiker kan zijn/haar eigen mailbox instellen op zijn/haar client
      * De gebruikers die aangemaakt worden werken, maar er is wel geen integratie met ldap.
- [X] Nagaan of hij spam binnen laat ( met GTUBE bericht) (te vinden in de documentatie)
  * Verwacht resultaat:
    * Bericht wordt gefilterd
- [X] Nagaan of ClamAV werkt door simulator (te vinden in de documentatie)
  * Verwacht resultaat:
    * Bericht met virus wordt gefilterd



