# Testrapport [Quebec1] (Getest op 3/12)

### Auteur(s) / Uitvoerder(s) testen:
- Jarne Verbeke
- Getest door Alex Devlies

## Uitgevoerde testen en het geleverde resultaat:

### Test 1: Voorbereiding

- [x] Master DNS server (Bravo1) is running
- [x] Slave DNS server (Charlie1) is running
- [x] Mailserver (Delta1) is running

### Test 2 : Basistest op Quebec
- [x] Er kan een SSH verbinding worden gemaakt naar Quebec1

```
ssh root@172.16.0.40
```
- [x] Ip adres komt overeen met 172.16.0.40
```
ip address
```
- [x] De dnsmasq services draaien
```
[root@quebec1 ~]# systemctl status dnsmasq.service
● dnsmasq.service - DNS caching server.
   Loaded: loaded (/usr/lib/systemd/system/dnsmasq.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-12-03 09:43:48 CET; 1h 22min ago
 Main PID: 1135 (dnsmasq)
   CGroup: /system.slice/dnsmasq.service
           └─1135 /usr/sbin/dnsmasq -k

Dec 03 09:43:48 quebec1.green.local dnsmasq[1135]: using nameserver 172.22.0.2#53
Dec 03 09:43:48 quebec1.green.local dnsmasq[1135]: ignoring nameserver 172.16.0.40 - local interface
Dec 03 09:43:48 quebec1.green.local dnsmasq[1135]: using nameserver 172.22.0.2#53
Dec 03 09:43:48 quebec1.green.local dnsmasq[1135]: using nameserver 8.8.8.8#53
Dec 03 09:43:48 quebec1.green.local dnsmasq[1135]: read /etc/hosts - 13 addresses
Dec 03 09:52:06 quebec1.green.local dnsmasq[1135]: nameserver 172.16.0.4 refused to do a recursive query
Dec 03 10:11:23 quebec1.green.local dnsmasq[1646]: nameserver 172.16.0.5 refused to do a recursive query
Dec 03 10:11:31 quebec1.green.local dnsmasq[1647]: nameserver 172.16.0.5 refused to do a recursive query
Dec 03 10:47:48 quebec1.green.local dnsmasq[1747]: nameserver 172.16.0.5 refused to do a recursive query
Dec 03 10:48:14 quebec1.green.local dnsmasq[1750]: nameserver 172.16.0.5 refused to do a recursive query

```
- [x] cat /etc/dnsmasq.conf heeft de juiste informatie
```
[root@quebec1 ~]# cat /etc/dnsmasq.conf
# Dnsmasq configuration
# Ansible managed

listen-address=172.16.0.40
domain-needed
bogus-priv

domain=green.local

server=172.22.0.2
server=8.8.8.8
server=/green.local/172.16.0.4
server=/green.local/172.16.0.5
server=/red.local/172.18.0.34
server=/red.local/172.18.0.35



conf-dir=/etc/dnsmasq.d

```

### Test 3 : Specifieke test op Delta1 via quebec1

- [x] Opzoeken ip-adres bravo1 via quebec1
```
[root@quebec1 ~]#  nslookup bravo1
Server:         172.16.0.40
Address:        172.16.0.40#53

Name:   bravo1.green.local
Address: 172.16.0.4

```
- [x] Opzoeken ip-adres website via quebec1
```
[root@quebec1 ~]# nslookup www.flair.be
Server:         172.16.0.40
Address:        172.16.0.40#53

Non-authoritative answer:
www.flair.be    canonical name = flair-be.production.women.aws.roularta.be.
flair-be.production.women.aws.roularta.be       canonical name = wome-flair-be-produ-0111-1199772360.eu-west-1.elb.amazonaws.com.
Name:   wome-flair-be-produ-0111-1199772360.eu-west-1.elb.amazonaws.com
Address: 34.251.161.7
Name:   wome-flair-be-produ-0111-1199772360.eu-west-1.elb.amazonaws.com
Address: 52.48.223.238

```
- [x] SSH verbinding naar delta1
```
ssh root@172.16.0.6
```
- [x] Dig werkt op delta1
```
[root@detla1 ~]# dig bravo1.green.local

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> bravo1.green.local
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 29776
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;bravo1.green.local.            IN      A

;; ANSWER SECTION:
bravo1.green.local.     0       IN      A       172.16.0.4

;; Query time: 0 msec
;; SERVER: 172.16.0.40#53(172.16.0.40)
;; WHEN: Mon Dec 03 11:40:44 CET 2018
;; MSG SIZE  rcvd: 63

```
- [x] Reverse lookup van een address (Vb kilo1)
```
[root@detla1 ~]# dig -x 172.16.0.34 +short
kilo1.green.local.
```

- [x] Dig van een publiek address
```
[root@detla1 ~]# dig www.hogent.be

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> www.hogent.be
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 31214
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 5

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.hogent.be.                 IN      A

;; ANSWER SECTION:
www.hogent.be.          3600    IN      A       178.62.144.90

;; AUTHORITY SECTION:
hogent.be.              3600    IN      NS      ns2.hogent.be.
hogent.be.              3600    IN      NS      ns1.hogent.be.

;; ADDITIONAL SECTION:
ns1.hogent.be.          3600    IN      A       193.190.173.1
ns1.hogent.be.          3600    IN      AAAA    2001:6a8:1c60:ab00::1
ns2.hogent.be.          3600    IN      A       193.190.173.2
ns2.hogent.be.          3600    IN      AAAA    2001:6a8:1c60:ab00::2

;; Query time: 3 msec
;; SERVER: 172.16.0.40#53(172.16.0.40)
;; WHEN: Mon Dec 03 11:43:45 CET 2018
;; MSG SIZE  rcvd: 182

```

- [x] Testen van de cache
![cashequebectest](https://user-images.githubusercontent.com/25815321/49369440-b6d89a80-f6f1-11e8-80c9-9e41f9ce6e45.JPG)
