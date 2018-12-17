# Testrapport Bravo 1 (Getest week 11 2/12 door Alex)

### Auteur:
- Jens Neirynck

### Tester(s):
- Alex Devlies

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Voorbereiding
- [x] Mailserver (Delta 1) is running
- [x] FWD DNS (Quebec 1) is running
- [x] AD (Alfa 1) is running

### Test 2: Basistests op Bravo
- [x] Er kan een SSH verbinding worden gemaakt naar Bravo
- [x] Ip adres komt overeen met 172.16.0.4 (ip a)
- [X] De Bind services draaien
    ```
        [root@bravo1 ~]# systemctl status named.service
    ● named.service - Berkeley Internet Name Domain (DNS)
       Loaded: loaded (/usr/lib/systemd/system/named.service; enabled; vendor preset: disabled)
       Active: active (running) since Mon 2018-12-03 08:34:39 CET; 43min ago
      Process: 1208 ExecStart=/usr/sbin/named -u named -c ${NAMEDCONF} $OPTIONS (code=exited, status=0/SUCCESS)
      Process: 1138 ExecStartPre=/bin/bash -c if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then /usr/sbin/named-checkconf -z "$NAMEDCONF"; else echo "Checking of zone files is disabled"; fi (code=exited, status=0/SUCCESS)
     Main PID: 1273 (named)
       CGroup: /system.slice/named.service
               └─1273 /usr/sbin/named -u named -c /etc/named.conf

    Dec 03 09:16:40 bravo1.green.local named[1273]: client 172.16.1.9#51961 (api.github.com): query (cache) 'api.github.com/A/IN' denied
    Dec 03 09:16:40 bravo1.green.local named[1273]: client 172.16.1.9#54391 (avatars1.githubusercontent.com): query (cache) 'avatars1.githubusercontent.com/A/IN' denied
    Dec 03 09:16:42 bravo1.green.local named[1273]: client 172.16.1.9#49687 (github.com): query (cache) 'github.com/A/IN' denied
    Dec 03 09:16:43 bravo1.green.local named[1273]: client 172.16.1.9#63246 (ocsp.digicert.com): query (cache) 'ocsp.digicert.com/A/IN' denied
    Dec 03 09:17:00 bravo1.green.local named[1273]: client 172.16.1.9#63159 (github.com): query (cache) 'github.com/A/IN' denied
    Dec 03 09:17:53 bravo1.green.local named[1273]: client 172.16.1.9#60128 (client-office365-tas.msedge.net): query (cache) 'client-office365-tas.msedge.net/A/IN' denied
    Dec 03 09:17:53 bravo1.green.local named[1273]: client 172.16.1.9#64625 (config.edge.skype.com): query (cache) 'config.edge.skype.com/A/IN' denied
    Dec 03 09:18:32 bravo1.green.local named[1273]: client 172.16.1.9#60996 (api.github.com): query (cache) 'api.github.com/A/IN' denied
    Dec 03 09:18:33 bravo1.green.local named[1273]: client 172.16.1.9#63090 (github.com): query (cache) 'github.com/A/IN' denied
    Dec 03 09:18:34 bravo1.green.local named[1273]: client 172.16.1.9#57196 (v10.events.data.microsoft.com): query (cache) 'v10.events.data.microsoft.com/A/IN' denied
    ```
- [x] cat /var/named/green.local heeft de juiste informatie
  ```
  [root@bravo1 ~]# cat /var/named/green.local
  ; Hash: 34fd7e8a473723f1d4050f88ecdc7cc3 1543243729
  ; Zone file for green.local
  ;
  ; Ansible managed
  ;

  $ORIGIN green.local.
  $TTL 1W

  @ IN SOA bravo1.green.local. hostmaster.green.local. (
    1543243729
    1D
    1H
    1W
    1D )

                       IN  NS     bravo1.green.local.
                       IN  NS     charlie1.green.local.

  @                    IN  MX     10  delta1.green.local.


  alfa1                IN  A      172.16.0.3
  dc                   IN  CNAME  alfa1
  bravo1               IN  A      172.16.0.4
  ns1                  IN  CNAME  bravo1
  charlie1             IN  A      172.16.0.5
  ns2                  IN  CNAME  charlie1
  delta1               IN  A      172.16.0.6
  mail                 IN  CNAME  delta1
  echo1                IN  A      172.16.0.7
  www                  IN  CNAME  echo1
  kilo1                IN  A      172.16.0.34
  dhcp                 IN  CNAME  kilo1
  lima1                IN  A      172.16.0.35
  ftp                  IN  CNAME  lima1
  mike1                IN  A      172.16.0.36
  cms                  IN  CNAME  mike1
  november1            IN  A      172.16.0.37
  db                   IN  CNAME  november1
  oscar1               IN  A      172.16.0.38
  monitor              IN  CNAME  oscar1
  papa1                IN  A      172.16.0.39
  pxe                  IN  CNAME  papa1
  quebec1              IN  A      172.16.0.40

  ```
- [x] cat /var/named/0.16.172.in-addrp heeft de juiste informatie
    ```
    [root@bravo1 ~]# cat /var/named/0.16.172.in-addr.arpa
    ; Hash: 5861c149d507f833d03a98180c165455 1543243729
    ; Reverse zone file for green.local
    ;
    ; Ansible managed
    ;

    $TTL 1W
    $ORIGIN 0.16.172.in-addr.arpa.

    @ IN SOA bravo1.green.local. hostmaster.green.local. (
      1543243729
      1D
      1H
      1W
      1D )

                     IN  NS   bravo1.green.local.
                     IN  NS   charlie1.green.local.

    3                IN  PTR  alfa1.green.local.
    4                IN  PTR  bravo1.green.local.
    5                IN  PTR  charlie1.green.local.
    6                IN  PTR  delta1.green.local.
    7                IN  PTR  echo1.green.local.
    34               IN  PTR  kilo1.green.local.
    35               IN  PTR  lima1.green.local.
    36               IN  PTR  mike1.green.local.
    37               IN  PTR  november1.green.local.
    38               IN  PTR  oscar1.green.local.
    39               IN  PTR  papa1.green.local.
    40               IN  PTR  quebec1.green.local.

    ```

### Test 3: Specifieke test op Delta 1
- [x] nslookup mail.green.local werkt (testen op Bravo)
  ```
  [root@bravo1 ~]# nslookup mail.green.local
  Server:         172.16.0.40
  Address:        172.16.0.40#53

  mail.green.local        canonical name = delta1.green.local.
  Name:   delta1.green.local
  Address: 172.16.0.6

  ```
- [x] nslookup 172.16.0.6 werkt (testen op Bravo)
  ```
  [root@bravo1 ~]# nslookup 172.16.0.6
  Server:         172.16.0.40
  Address:        172.16.0.40#53

  6.0.16.172.in-addr.arpa name = delta1.green.local.

  ```
- [x] SSH verbinding naar Delta 1 lukt

- [x] nslookup dc.green.local werkt
  ```
  [root@detla1 ~]# nslookup dc.green.local
  Server:         172.16.0.40
  Address:        172.16.0.40#53

  dc.green.local  canonical name = alfa1.green.local.
  Name:   alfa1.green.local
  Address: 172.16.0.3

  ```
- [x] nslookup 172.16.0.3 werkt
  ```
  [root@detla1 ~]# nslookup 172.16.0.3
  Server:         172.16.0.40
  Address:        172.16.0.40#53

  3.0.16.172.in-addr.arpa name = alfa1.green.local.

  ```
- [x] dig dc.green.local werkt
  ```
  [root@detla1 ~]# dig dc.green.local

  ; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> dc.green.local
  ;; global options: +cmd
  ;; Got answer:
  ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37805
  ;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 3

  ;; OPT PSEUDOSECTION:
  ; EDNS: version: 0, flags:; udp: 4096
  ;; QUESTION SECTION:
  ;dc.green.local.                        IN      A

  ;; ANSWER SECTION:
  dc.green.local.         604800  IN      CNAME   alfa1.green.local.
  alfa1.green.local.      604800  IN      A       172.16.0.3

  ;; AUTHORITY SECTION:
  green.local.            604800  IN      NS      charlie1.green.local.
  green.local.            604800  IN      NS      bravo1.green.local.

  ;; ADDITIONAL SECTION:
  bravo1.green.local.     604800  IN      A       172.16.0.4
  charlie1.green.local.   604800  IN      A       172.16.0.5

  ;; Query time: 1 msec
  ;; SERVER: 172.16.0.40#53(172.16.0.40)
  ;; WHEN: Mon Dec 03 09:29:24 CET 2018
  ;; MSG SIZE  rcvd: 155
  ```
- [x] dig -x 172.16.0.3 werkt
  ```
  [root@detla1 ~]# dig -x 172.16.0.3

  ; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> -x 172.16.0.3
  ;; global options: +cmd
  ;; Got answer:
  ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 65180
  ;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

  ;; OPT PSEUDOSECTION:
  ; EDNS: version: 0, flags:; udp: 4096
  ;; QUESTION SECTION:
  ;3.0.16.172.in-addr.arpa.       IN      PTR

  ;; ANSWER SECTION:
  3.0.16.172.in-addr.arpa. 0      IN      PTR     alfa1.green.local.

  ;; Query time: 0 msec
  ;; SERVER: 172.16.0.40#53(172.16.0.40)
  ;; WHEN: Mon Dec 03 09:32:00 CET 2018
  ;; MSG SIZE  rcvd: 83

  ```

### Test 4: Specifieke test op Alfa 1
- [x] nslookup dc.green.local werkt (testen op Bravo)
```
[root@bravo1 ~]# nslookup dc.green.local
Server:         172.16.0.40
Address:        172.16.0.40#53

dc.green.local  canonical name = alfa1.green.local.
Name:   alfa1.green.local
Address: 172.16.0.3

```
- [x] nslookup 172.16.0.3 werkt (testen op Bravo)
```
[root@bravo1 ~]# nslookup 172.16.0.3
Server:         172.16.0.40
Address:        172.16.0.40#53

3.0.16.172.in-addr.arpa name = alfa1.green.local.

```
- [x] SSH verbinding naar Alfa 1 lukt
- [x] nslookup mail.green.local werkt
```
[root@alfa1 ~]# nslookup mail.green.local
Server:         172.16.0.40
Address:        172.16.0.40#53

mail.green.local        canonical name = delta1.green.local.
Name:   delta1.green.local
Address: 172.16.0.6

```
- [x] nslookup 172.16.0.6 werkt
```
[root@alfa1 ~]# nslookup 172.16.0.6
Server:         172.16.0.40
Address:        172.16.0.40#53

6.0.16.172.in-addr.arpa name = delta1.green.local.

```
- [x] dig mail.green.local werkt
```
[root@alfa1 ~]# dig mail.green.local

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> mail.green.local
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 41783
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;mail.green.local.              IN      A

;; ANSWER SECTION:
mail.green.local.       604800  IN      CNAME   delta1.green.local.
delta1.green.local.     604800  IN      A       172.16.0.6

;; AUTHORITY SECTION:
green.local.            604800  IN      NS      charlie1.green.local.
green.local.            604800  IN      NS      bravo1.green.local.

;; ADDITIONAL SECTION:
bravo1.green.local.     604800  IN      A       172.16.0.4
charlie1.green.local.   604800  IN      A       172.16.0.5

;; Query time: 1 msec
;; SERVER: 172.16.0.40#53(172.16.0.40)
;; WHEN: Mon Dec 03 12:00:32 CET 2018
;; MSG SIZE  rcvd: 158

```
- [x] dig -x 172.16.0.6 werkt
```
[root@alfa1 ~]# dig -x 172.16.0.6

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> -x 172.16.0.6
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2538
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;6.0.16.172.in-addr.arpa.       IN      PTR

;; ANSWER SECTION:
6.0.16.172.in-addr.arpa. 0      IN      PTR     delta1.green.local.

;; Query time: 0 msec
;; SERVER: 172.16.0.40#53(172.16.0.40)
;; WHEN: Mon Dec 03 12:01:12 CET 2018
;; MSG SIZE  rcvd: 84

```
