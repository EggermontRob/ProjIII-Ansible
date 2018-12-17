# Quebec 1 DNS Forward server DNSMASQ

## Starten van de machine
* Open de project folder en voer het commando vagrant up quebec1. Indien de machine al geprovisioned is doe vagrant provision quebec1.
	* Dit zou geen fouten mogen geven. Indien er toch problemen optreden kan het verstandig zijn om de machine te destroyen. Gebruik
	```
	vagrant destroy quebec1
	```
* Na het up brengen van de machine kan je verbinding maken met het commando vagrant ssh quebec1.

## Testen van de cache
* Voer het commando om naar de root te gaan.
```
sudo -i
```
* Hier installeren we dan tcpdump.
```
yum install tcpdump -y
```
![afbeelding](https://user-images.githubusercontent.com/25815893/47286700-21c18c80-d5f0-11e8-81e1-c10509cdc0e0.png)

* Voer nu een commando uit om alle netwerkverkeer te bekijken.Wij maken gebruik van tcpdump.
```
tcpdump -i any udp port 53 -n
```
![afbeelding](https://user-images.githubusercontent.com/25815893/47286778-68af8200-d5f0-11e8-933c-93be552bca57.png)

* Open een tweede terminal en maak hier gebruik van nslookup.
```
time nslookup www.flair.be localhost
```
* Bij de eerste keer uitvoeren krijgen we deze output.
	![afbeelding](https://user-images.githubusercontent.com/25815893/47287068-4ff39c00-d5f1-11e8-88f0-f640f396cb8e.png)
* Bij de tweede keer krijgen we deze.
	![afbeelding](https://user-images.githubusercontent.com/25815893/47287403-6b12db80-d5f2-11e8-91bc-1541b663a522.png)

* Indien je dezelfde resultaten kreeg als bij optie twee dan werkt de cache.
