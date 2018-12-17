# Testplan Kilo1

### Auteur(s):
- Lennert Mertens

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Opstarten VM.
- [x] Ga naar command-line van map met vagrant-file van Kilo1
- [x] Controleer of VM al is aangemaakt (`vagrant status`), Kilo1 moet "Not Created" zijn, anders `Vagrant destroy Kilo1` commando uitvoeren.
- [x] Aanmaken van Kilo1 met `Vagrant up Kilo1`

* Verwachte resultaten:
    ```
    ==> kilo1: PLAY RECAP ***********************************************
    ==> kilo1: kilo1     : ok=7    changed=5    unreachable=0    failed=0

    ```

## Test 2 - DHCP installatie:  

- [x] Ga met commandos `root@172.16.0.34 ` & `rpm -q dhcp` na of DHCP geïnstalleerd is op Kilo1.

* Verwachte resultaat:  

  ```
    dhcp-4.2.5-58.el7.centos.x86_64
  ```
## Test 3 - DHCP service:

- [x] Test of de status van DHCP 'Running' is op Kilo1 met commando `systemctl status dhcpd.service`

* Verwachte uitkomst:
```
   ● dhcpd.service - DHCPv4 Server Daemon
   Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2018-11-02 19:10:16 UTC; 1min 6s ago
     Docs: man:dhcpd(8)
           man:dhcpd.conf(5)
 Main PID: 11853 (dhcpd)
   Status: "Dispatching packets..."
   CGroup: /system.slice/dhcpd.service
           └─11853 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid

Nov 02 19:10:16 kilo1.green.local dhcpd[11853]: Sending on   LPF/eth1/08:00:27:a5:48:12/172.16.0.32/27
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:     
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:    
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:    
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]:
Nov 02 19:10:16 kilo1.green.local dhcpd[11853]: Sending on   Socket/fallback/fallback-net
Nov 02 19:10:16 kilo1.green.local systemd[1]: Started DHCPv4 Server Daemon.

```
## Test 4 - dhcpd.conf

- [x] Test of het configuratiebestand klopt met commando: `sudo cat /etc/dhcp/dhcpd.conf `

* Verwacht Resultaat: (Dit wijkt af omdat het op ansible nog niet mogelijk is om 'shared-networks' te configureren, dus wordt het hier met de hand gedaan)

```
next-server 172.16.0.39;
filename "pxelinux.0"
default-lease-time 28800;
max-lease-time 43200;
option routers 172.16.0.33;
option domain-name "green.local";
option domain-name-servers 172.16.0.40, 172.16.0.4, 172.16.0.5;

subnet 172.16.0.32 netmask 255.255.255.224{
   filename "pxelinux.0"
allow bootp;
allow booting;
}
shared-network clients{
subnet 172.16.1.0 netmask 255.255.255.192 {
  option routers 172.16.1.1;
  option subnet-mask 255.255.255.192;
  range 172.16.1.8 172.16.1.62;
allow bootp;
allow booting;
filename "pxelinux.0";
}

host WS0 {
  hardware ethernet 52:54:00:C2:B2:F9;
  fixed-address 172.16.1.3;
}
host WS1 {
  hardware ethernet 52:54:00:24:AB:6D;
  fixed-address 172.16.1.4;
}
host WS2 {
  hardware ethernet 52:54:00:C3:F4:A4;
  fixed-address 172.16.1.5;
}
host WS3 {
  hardware ethernet 52:54:00:18:C8:4B;
  fixed-address 172.16.1.6;
}
host WS4 {
  hardware ethernet 52:54:00:2C:22:49;
  fixed-address 172.16.1.7;
}
}
```

## Test 5a - Test 1 - Test met eigen machine (5/11/2018)
- Geprobeerd om IP adres te verkrijgen via DHCP, dit lukt niet omdat de DHCPOFFER's vanop de DHCP  server niet worden teruggestuurd naar de host
- Fouten in het netwerk (switch) en niet met de DHCP server

## Test 5a - Test 2 - Test met eigen machine (03/12/2018)
- Mac-adres van PC jarne werd toegevoegd aan de config van DHCP server
- PC jarne werd via dhcp verbonden met het netwerk en kreeg IP - adres 172.16.1.3

```
Ethernet adapter Ethernet 2:

   Connection-specific DNS Suffix  . : green.local
   IPv6 Address. . . . . . . . . . . : 2001:db8:acad:a::3
   Link-local IPv6 Address . . . . . : fe80::6ca7:373d:d986:3599%15
   IPv4 Address. . . . . . . . . . . : 172.16.1.3
   Subnet Mask . . . . . . . . . . . : 255.255.255.192
   Default Gateway . . . . . . . . . : 172.16.1.1
```

## Test 5b - DHCP-client
- Werkt nog niet 
- [x] Maak DHCP-Client aan met specifiek MAC-Adress "A0CEC819DD30" en boot deze
- [x] DHCP-Client krijgt IP "172.16.1.3" van Kilo1

* Verwacht resultaat (05/11/2018):
    - Bekijk de netwerksettings met het commando `ip a`
    - De interface zou een IP-adres moeten krijgen op basis van zijn MAC adres. Het MAC-adres dat je hebt ingesteld, zou moeten overeen komen met het IP-adres `172.16.1.3` uit de configuratiefile van DHCP.

* Verwacht resultaat (03/12/2018)
    - Computer krijgt het adres
    - DHCP werkt!
