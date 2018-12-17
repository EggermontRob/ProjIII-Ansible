# Testplan [quebec1]

### Auteur(s):
- Artuur Fiems
- Jarne Verbeke


## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: IP - name config

- [ ] IP adres werd correct ingesteld
  - ```ip address```
  Verwachte waarde: 172.16.0.40
- [ ] FQDN werd correct ingesteld
  - ```hostname``` 
  Verwachte waarde: `quebec1.green.local`
  
### Test 2: Testen via hostsysteem : Lokale naam naar IP-adres 

- [ Uitleg nslookup commando ]

Commando : 
```
nslookup [name] [server]
```
Name : 

Name van een server (VB: delta1.green.local)

Name van een website (VB: www.flair.be)

Server : 

Server die gebruikt wordt om de domein naam om te zetten in een IP-adres.

- [ bravo1 is bereikbaar via quebec1 ] 

Commando :
```
nslookup bravo1
```
Output : 
```
Server:         172.16.0.40
Address:        172.16.0.40#53

Name:   bravo1.green.local
Address: 172.16.0.4

```
- [ mike1 is bereikbaar via quebec1 ] 

Commando : 
```
nslookup mike1
```
Output : 
```
Server:         172.16.0.40
Address:        172.16.0.40#53

Name:   mike1.green.local
Address: 172.16.0.36

```
- [ kilo1 is bereikbaar via quebec1 ] 

Commando : 
```
nslookup kilo1
```
Output : 
```
Server:         172.16.0.40
Address:        172.16.0.40#53

Name:   kilo1.green.local
Address: 172.16.0.34

```
### Test 3: Testen via hostsysteem : Website naar IP-adres

- [ DNS van website naar IP-adres ]

Commando : 
```
nslookup www.flair.be 
```
Output : 
```
Server:         172.16.0.40
Address:        172.16.0.40#53

Non-authoritative answer:
www.flair.be    canonical name = flair-be.production.women.aws.roularta.be.
flair-be.production.women.aws.roularta.be       canonical name = wome-flair-be-produ-0111-1199772360.eu-west-1.elb.amazonaws.com.
Name:   wome-flair-be-produ-0111-1199772360.eu-west-1.elb.amazonaws.com
Address: 54.229.103.68
Name:   wome-flair-be-produ-0111-1199772360.eu-west-1.elb.amazonaws.com
Address: 34.248.75.6

```

### Test 4: Testen van hostsysteem : Cache mbv delta1.

- [ Installeren tcpdump ]
```
sudo -i
yum install tcpdump -y
```

- [ Testen cache ]
Terminal 1 : Quebec1 : 
```
tcpdump -i any udp port 53 -n
```

Terminal 1 : Delta1 : Eerste opzoeking
```
nslookup www.hln.be 
```
Output op terminal quebec1 :
```
10:28:21.772794 IP 172.16.0.6.42784 > 172.16.0.40.domain: 60380+ A? www.hln.be.      (28)
10:28:21.773225 IP 10.0.2.15.34871 > 193.191.158.15.domain: 3096+ A? www.hln.be.      (28)
10:28:21.773782 IP 172.16.0.40.34871 > 172.16.0.4.domain: 3096+ A? www.hln.be. (     28)
10:28:21.774157 IP 10.0.2.15.34871 > 195.130.130.11.domain: 3096+ A? www.hln.be.      (28)
10:28:21.774844 IP 10.0.2.15.34871 > 195.130.130.139.domain: 3096+ A? www.hln.be     . (28)
10:28:21.775309 IP 10.0.2.15.34871 > 195.238.2.21.domain: 3096+ A? www.hln.be. (     28)
10:28:21.775999 IP 10.0.2.15.34871 > 195.238.2.22.domain: 3096+ A? www.hln.be. (     28)
10:28:21.777517 IP 172.16.0.4.domain > 172.16.0.40.34871: 3096 Refused- 0/0/0 (2     8)
10:28:21.795938 IP 195.130.130.139.domain > 10.0.2.15.34871: 3096 3/0/0 CNAME ss     l-be.persgroep.edgekey.net., CNAME e8838.dscksd.akamaiedge.net., A 104.104.202.1     30 (124)
10:28:21.797164 IP 195.130.130.11.domain > 10.0.2.15.34871: 3096 3/0/0 CNAME ssl     -be.persgroep.edgekey.net., CNAME e8838.dscksd.akamaiedge.net., A 104.104.202.13     0 (124)
10:28:21.798687 IP 172.16.0.40.domain > 172.16.0.6.42784: 60380 3/0/0 CNAME ssl-     be.persgroep.edgekey.net., CNAME e8838.dscksd.akamaiedge.net., A 104.104.202.130      (124)
```

Terminal 2 : Delta1 : Tweede opzoeking
```
nslookup www.hln.be 
```
Output op terminal quebec1 : 
```
10:32:44.144534 IP 172.16.0.6.44067 > 172.16.0.40.domain: 41356+ A? www.hln.be. (28)
10:32:44.145420 IP 172.16.0.40.domain > 172.16.0.6.44067: 41356 3/0/0 CNAME ssl-be.persgroep.edgekey.net., CNAME e8838.dscksd.akamaiedge.net., A 104.104.202.130 (127)
```

...

