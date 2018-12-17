# Testplan Charlie 1 (Getest op 3/12)

### Auteur:
- Jens Neirynck

### Testers:
- Alex Devlies

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Voorbereiding
- [x] Mailserver (Delta 1) is running
- [x] FWD DNS (Quebec 1) is running
- [x] AD (Alfa 1) is running
- [x] Bravo 1 (ns1) is running

### Test 2: Basistests op Charlie
- [x] Er kan een SSH verbinding worden gemaakt naar Charlie
- [x] Ip adres komt overeen met 172.16.0.5 (ip a)
- [x] De Bind services draaien
  ```
  [root@charlie1 ~]# systemctl status named.service
  ● named.service - Berkeley Internet Name Domain (DNS)
     Loaded: loaded (/usr/lib/systemd/system/named.service; enabled; vendor preset: disabled)
     Active: active (running) since Mon 2018-12-03 09:40:11 CET; 56s ago
    Process: 1320 ExecStart=/usr/sbin/named -u named -c ${NAMEDCONF} $OPTIONS (code=exited, status=0/SUCCESS)
    Process: 1140 ExecStartPre=/bin/bash -c if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then /usr/sbin/named-checkconf -z "$NAMEDCONF"; else echo "Checking of zone files is disabled"; fi (code=exited, status=0/SUCCESS)
   Main PID: 1323 (named)
     CGroup: /system.slice/named.service
             └─1323 /usr/sbin/named -u named -c /etc/named.conf

  Dec 03 09:40:11 charlie1.green.local named[1323]: zone localhost/IN: loaded serial 0
  Dec 03 09:40:11 charlie1.green.local named[1323]: all zones loaded
  Dec 03 09:40:11 charlie1.green.local named[1323]: running
  Dec 03 09:40:11 charlie1.green.local named[1323]: zone 0.16.172.in-addr.arpa/IN: sending notifies (serial 1543243729)
  Dec 03 09:40:11 charlie1.green.local named[1323]: zone green.local/IN: sending notifies (serial 1543243729)
  Dec 03 09:40:11 charlie1.green.local systemd[1]: Started Berkeley Internet Name Domain (DNS).
  Dec 03 09:40:17 charlie1.green.local named[1323]: client 172.16.0.4#44737: received notify for zone 'green.local'
  Dec 03 09:40:17 charlie1.green.local named[1323]: zone green.local/IN: notify from 172.16.0.4#44737: zone is up to date
  Dec 03 09:40:18 charlie1.green.local named[1323]: client 172.16.0.4#20727: received notify for zone '0.16.172.in-addr.arpa'
  Dec 03 09:40:18 charlie1.green.local named[1323]: zone 0.16.172.in-addr.arpa/IN: notify from 172.16.0.4#20727: zone is up to date

  ```
- [x] cat /var/named/slaves/green.local heeft de juiste informatie
  ```
  [root@charlie1 ~]# cat /var/named/slaves/green.local
  [▒
  greenlocal@bravo1greenlocal
  greenlocalgreenlocal[▒▒Q▒       :▒Q▒9   :▒
  greenlocalbravo1greenlocacharlie1greenlocal-    :▒alfa1greenlocal▒.     :▒bravo1greenlocal▒0    :charlie1greenlocal▒:   :▒cmsgreenlocalmike1greenlocal= :▒dbgreenlocal  november1greenlocal9    :▒dcgreenlocalalfa1greenlocal.  :▒delta1greenlocal▒;    :▒dhcpgreenlocalkilo1greenlocal-       :▒echo1greenlocal▒:     :▒ftpgreenlocallima1greenlocal- :▒kilo1greenlocal▒"-    :▒lima1greenlocal▒#<    :▒mailgreenlocaldelta1greenlocal-       :▒mike1greenlocal▒$?    :▒monitorgreenlocaloscar1greenlocal1    :▒      november1greenlocal▒%;  :▒ns1greenlocalbravo1greenlocal=       :▒ns2greenlocacharlie1greenlocal.       :▒oscar1greenlocal▒&-   :▒papa1greenlocal▒':    :▒pxegreenlocalpapa1greenlocal/ :▒quebec1greenlocal▒(:  :▒wwwgreenlocalecho1greenlocal
  ```
- [x] cat /var/named/slaves/0.16.172.in-addrp heeft de juiste informatie
  ```
  [root@charlie1 ~]# cat /var/named/slaves/0.16.172.in-addr.arpa
  [▒
    im    :▒016172in-addrarpa@bravo1greenlocal
  hostmastergreenlocal[▒▒Q▒       :▒Q▒Y   :▒016172in-addrarpabravo1greenlocacharlie1greenlocalB
                                                                                                  :▒3016172in-addrarpaalfa1greenlocalC
                                                                                                                                       :▒34016172in-addrarpakilo1greenlocalC
                                          :▒35016172in-addrarpalima1greenlocalC
                                                                                  :▒36016172in-addrarpamike1greenlocalG
                                                                                                                          :▒37016172in-addrarpa november1greenlocalD
                                  :▒38016172in-addrarpaoscar1greenlocalC
                                                                          :▒39016172in-addrarpapapa1greenlocalC
                                                                                                                  :▒4016172in-addrarpabravo1greenlocalE
                  :▒40016172in-addrarpaquebec1greenlocalE
                                                          :▒5016172in-addrarpcharlie1greenlocalC
                                                                                                  :▒6016172in-addrarpadelta1greenlocalB
                                                                                                                                       :▒7016172in-addrarpaecho1greenlocal
  ```

### Test 3: Specifieke test op Delta 1 via Bravo
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
  ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7969
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
  ;; WHEN: Mon Dec 03 09:54:51 CET 2018
  ;; MSG SIZE  rcvd: 155

  ```
- [x] dig -x 172.16.0.3 werkt
  ```
  [root@detla1 ~]# dig -x 172.16.0.3

  ; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> -x 172.16.0.3
  ;; global options: +cmd
  ;; Got answer:
  ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12465
  ;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

  ;; OPT PSEUDOSECTION:
  ; EDNS: version: 0, flags:; udp: 4096
  ;; QUESTION SECTION:
  ;3.0.16.172.in-addr.arpa.       IN      PTR

  ;; ANSWER SECTION:
  3.0.16.172.in-addr.arpa. 0      IN      PTR     alfa1.green.local.

  ;; Query time: 0 msec
  ;; SERVER: 172.16.0.40#53(172.16.0.40)
  ;; WHEN: Mon Dec 03 09:55:43 CET 2018
  ;; MSG SIZE  rcvd: 83

  ```

### Test 4: Slave replicatie test
- [x] Sluit Bravo 1 af
- [x] SSH verbinding naar Charlie maken
- [x] nslookup mail.green.local werkt (testen op Charlie)
```
[root@charlie1 ~]# nslookup mail.green.local
Server:         172.16.0.40
Address:        172.16.0.40#53

mail.green.local        canonical name = delta1.green.local.
Name:   delta1.green.local
Address: 172.16.0.6

```
- [x] nslookup 172.16.0.6 werkt (testen op Charlie)
```
[root@charlie1 ~]# nslookup 172.16.0.6
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
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 28844
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;dc.green.local.                        IN      A

;; ANSWER SECTION:
dc.green.local.         604800  IN      CNAME   alfa1.green.local.
alfa1.green.local.      604800  IN      A       172.16.0.3

;; AUTHORITY SECTION:
green.local.            604800  IN      NS      bravo1.green.local.
green.local.            604800  IN      NS      charlie1.green.local.

;; ADDITIONAL SECTION:
bravo1.green.local.     604800  IN      A       172.16.0.4
charlie1.green.local.   604800  IN      A       172.16.0.5

;; Query time: 1 msec
;; SERVER: 172.16.0.40#53(172.16.0.40)
;; WHEN: Mon Dec 03 10:03:06 CET 2018
;; MSG SIZE  rcvd: 155

```
- [x] dig -x 172.16.0.3 werkt
```
[root@detla1 ~]# dig -x 172.16.0.3

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7_5.1 <<>> -x 172.16.0.3
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 53
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;3.0.16.172.in-addr.arpa.       IN      PTR

;; ANSWER SECTION:
3.0.16.172.in-addr.arpa. 0      IN      PTR     alfa1.green.local.

;; Query time: 0 msec
;; SERVER: 172.16.0.40#53(172.16.0.40)
;; WHEN: Mon Dec 03 10:03:30 CET 2018
;; MSG SIZE  rcvd: 83

```
