# Testplan Charlie 1


## Alle te testen onderdelen in secties onderverdeeld: 

### Aanwezigheid van Deliverables

| Vereist       | Aanwezig      | Commentaar |
| ------------- |:-------------:| ---------- |
| Vagrantfile         | |   |
| vagrantConfig.sh (file met Vagrant configuraties) | |   |
| Mailserver moet running zijn (delta) | |   |
| AD moet running zijn (alfa) | |   |

### Vagrant server opstarten
- [ ] Vagrant up start de machine
- [ ] Er is geen gebruikerstussenkomst tijdens de installatie
- [ ] De installatie verloopt zonder errors
- [ ] Na de uitvoering van het script kunnen we aanloggen op de VM


## Werking van Charlie
### Stappen voor het testen
- [ ] Nagaan van de IP addressseringen: `ip a`
- [ ] Nagaan of alle services draaien
- [ ] nslookup mail.green.local 172.16.0.5
- [ ] nslookup 172.16.0.6 172.16.0.5
- [ ] dig dc.green.local @172.16.0.5
- [ ] dig 172.16.0.3 @172.16.0.5
- [ ] cat /var/named/slaves/...
- [ ] cat /var/named/slaves/0.16.172.in-addrp

Auteur testplan: Jens Neirynck


