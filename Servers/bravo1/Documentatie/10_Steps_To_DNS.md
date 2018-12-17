# 10 Steps To Configure DNS Server:
*Informatie gehaald uit video [Video](https://www.youtube.com/watch?v=0X9em99Vcl0). Alles wordt uitgevoerd in `sudo su`. BELANGERIJK: deze configuratie is voor een enkele DNS-Server zonder slave!*

## Step 1:
### Install DNS Package:
`yum install -y bind*`

## Step 2:
### Assign A Static IP Address:
* Edit:
`vim /etc/sysconfig/network-scripts/ifcfg-ethO`
* Vul aan met:
```
IPADDR=172.16.0.4
NETMASK=255.255.255.224
GATEWAY=(Default Gateway van Netwerk)
```

## Step 3:
### Assign A FQDN For Server:
*FQDN (Fully Qualified Domain Name)*

* Edit:
`vim /etc/sysconfig/network`
* Vul aan met:
```
NETWORKING=yes
HOSTNAME=bravo1.green.local
```

## Step 4:
### Configure /etc/hosts
* Edit:
`vim /etc/hosts`
* Vul aan met:
```
172.16.0.4 bravo1.green.local
```

## Step 5:
### Configure /etc/resolv.conf (obsolete)
* Edit:
`vim /etc/resolv.conf`
* Vul aan met:
```
search green.local
nameserver 172.16.0.4
```
* Eventueel andere nameservers in comment zetten.

## Step 6:
### Configure /etc/named.conf:
* Edit:
`vim /etc/named.conf`
* Replace localhost with static ip:
`Listen-on port 53 {172.16.0.4; };`
* Als aanwezig zet in comment:
`listen-on-v6 port 53 {::1;};`
* Replace none with any:
`allow-query {any;};`

## Step 7:
### Configure /etc/rfc.1912.zones:
* Edit:
`vim /etc/named.rfc1912.zones`
* Vul aan:
```
zone "green.local" IN
file "forward.zone";
zone "0.16.172.in-addr.arpa" IN
file "reverse.zone";
```

## Step 8:
### Configure Forward & Reverse Zones:
* Navigeer:
```
cd /var/named/
ls /var/named/
```
* Controleer ofdat forward.zone & reverse.zone aanwezig zijn.
* Indien niet aanwezig:
```
cp named.localhost forward.zone
cp named.localhost reverse.zone
```
* Edit:
`vim forward.zone`
* Vul aan:
```
$TTL 1D
@	IN SOA bravo1.green.local. root.bravo1.green.local. (
				0	; serial
				1D	; refresh
				1H	; retry
				1W	; expire
				3H )	; minimum
	IN NS bravo1.green.local.
(d?)ns1	IN A  172.16.0.4
```
* Edit:
`vim reverse.zone`
* Vul aan:
```
$TTL 1D
@       IN SOA bravo1.green.local. root.bravo1.green.local. (
                                0       ; serial
                                1D      ; refresh
                                1H      ; retry
                                1W      ; expire
                                3H )    ; minimum
        IN NS  bravo1.green.local.
4	IN PTR bravo1.green.local.
```

## Step 9:
### Change The Group Ownership:
* Verander group owner voor forward.zone:
`chgrp named /var/named/forward.zone`
* Verander group owner voor reverse.zone:
`chgrp named /var/named/reverse.zone`

## Step 10:
### Restart DNS Service:
* Herstart:
`service named restart`

## Step 11:
### Controleren Na Restart:
* Controle:
```
dig
nslookup ns1.green.local
nslookup 172.16.0.4
```

## Step 12:
### Client DNS Instellen:
* Step 5 overlopen.

## Step 13:
*Eventueel nog de poorten open zetten op de firewall indien nodig!*

