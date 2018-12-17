# Testrapport Bravo 1

### Auteur(s):
- Jens Neirynck
- Alex Devlies(Tester)

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Voorbereiding
- [X] Mailserver (Delta 1) is running
- [X] FWD DNS (Quebec 1) is running
- [X] AD (Alfa 1) is running

### Test 2: Basistests op Bravo
- [X] Er kan een SSH verbinding worden gemaakt naar Bravo
- [X] Ip adres komt overeen met 172.16.0.4 (ip a)
- [X] De Bind services draaien
    - 'systemctl status named'

    ```
    [root@bravo1 ~]# systemctl status named
    ● named.service - Berkeley Internet Name Domain (DNS)
       Loaded: loaded (/usr/lib/systemd/system/named.service; enabled; vendor preset: disabled)
       Active: active (running) since Mon 2018-11-26 09:13:44 CET; 2h 34min ago
      Process: 7743 ExecReload=/bin/sh -c /usr/sbin/rndc reload > /dev/null 2>&1 || /bin/kill -HUP $MAINPID (code=e                    xited, status=0/SUCCESS)
     Main PID: 7499 (named)
       CGroup: /system.slice/named.service
               └─7499 /usr/sbin/named -u named -c /etc/named.conf

    Nov 26 11:14:10 bravo1.green.local named[7499]: error (network unreachable) resolving 'dlv.isc.org/DNSKE...5#53
    Nov 26 11:14:10 bravo1.green.local named[7499]: error (network unreachable) resolving 'dlv.isc.org/DNSKE...1#53
    Nov 26 11:14:10 bravo1.green.local named[7499]: error (network unreachable) resolving 'dlv.isc.org/DNSKE...5#53
    Nov 26 11:14:10 bravo1.green.local named[7499]: error (network unreachable) resolving 'dlv.isc.org/DNSKE...0#53
    Nov 26 11:14:11 bravo1.green.local named[7499]: error (network unreachable) resolving './DNSKEY/IN': 200...d#53
    Nov 26 11:14:11 bravo1.green.local named[7499]: error (network unreachable) resolving './NS/IN': 2001:50...d#53
    Nov 26 11:14:11 bravo1.green.local named[7499]: error (network unreachable) resolving 'dlv.isc.org/DNSKE...2#53
    Nov 26 11:14:11 bravo1.green.local named[7499]: error (network unreachable) resolving 'dlv.isc.org/DNSKE...d#53
    Nov 26 11:14:12 bravo1.green.local named[7499]: managed-keys-zone: Unable to fetch DNSKEY set '.': timed out
    Nov 26 11:14:12 bravo1.green.local named[7499]: managed-keys-zone: Unable to fetch DNSKEY set 'dlv.isc.o... out
    Hint: Some lines were ellipsized, use -l to show in full.
    ```
- [X] cat /var/named/green.local heeft de juiste informatie
    - '; Hash: 1cb081fb4c827de4c61abb7148cd9e20 1542620048
        ; Zone file for green.local
        ;
        ; Ansible managed
        ;

        $ORIGIN green.local.
        $TTL 1W

        @ IN SOA bravo1.green.local. hostmaster.green.local. (1542620048 1D 1H 1W 1D )

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
        quebec1              IN  A      172.16.0.40'

- [X] cat /var/named/0.16.172.in-addrp heeft de juiste informatie
    ```
    [root@bravo1 ~]# cat /var/named/0.16.172.in-addr.arpa
    ; Hash: 5861c149d507f833d03a98180c165455 1545032251
    ; Reverse zone file for green.local
    ;
    ; Ansible managed
    ;

    $TTL 1W
    $ORIGIN 0.16.172.in-addr.arpa.

    @ IN SOA bravo1.green.local. hostmaster.green.local. (
      1545032251
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
-
### Test 3: Specifieke test op Delta 1
- [X] nslookup mail.green.local werkt (testen op Bravo)
- [X] nslookup 172.16.0.6 werkt (testen op Bravo)

- [X] SSH verbinding naar Delta 1 lukt
- [X] nslookup dc.green.local werkt
- [X] nslookup 172.16.0.3 werkt
- [X] dig dc.green.local werkt
- [X] dig -x 172.16.0.3 werkt

### Test 4: Specifieke test op Alfa 1
- [X] nslookup dc.green.local werkt (testen op Bravo)
- [X] nslookup 172.16.0.3 werkt (testen op Bravo)

- [X] SSH verbinding naar Alfa 1 lukt
- [X] nslookup mail.green.local werkt
- [X] nslookup 172.16.0.6 werkt
- [X] dig mail.green.local werkt
- [X] dig -x 172.16.0.6 werkt
