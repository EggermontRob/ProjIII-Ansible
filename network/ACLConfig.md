# ACL Configuratie

1. ACL op Switch2: source any, destination is vlan50, alleen specifieke poorten toelaten
2. Poorten nodig:

| POORTNUMMER | TCP/UDP | PROTOCOL |
| --- | --- | --- |
| 80 | Tcp | HTTP |
| 389 | Tcp | LDAP |
| 9830 | Tcp | EMC2 (Legato) Networker or Sun Solcitice Backup (Official) |
| 636 | Tcp | LDAPS |
| 3269 | Tcp | Microsoft Global Catalog with LDAP/SSL |
| 53 | Tcp/udp | DNS |
| 143 | Tcp (udp) | Imap |
| 993 | Tcp (udp) | Imaps |
| 110 | Tcp (udp) | Pop3 |
| 995 | Tcp (udp) | Pop3s |
| 25 | Tcp (udp) | Smtp |
| 465 | tcp | Smtps |
| 587 | Tcp (udp) | Smtp-submission |
| 443 | tcp | https |

Config:
```
ip access-list extended alleenPubliekeServers

permit tcp any 172.16.0.0 0.0.0.31 eq 80

permit tcp any 172.16.0.0 0.0.0.31 eq 389

permit tcp any 172.16.0.0 0.0.0.31 eq 9830

permit tcp any 172.16.0.0 0.0.0.31 eq 636

permit tcp any 172.16.0.0 0.0.0.31 eq 3269

permit tcp any 172.16.0.0 0.0.0.31 eq 53

permit udp any 172.16.0.0 0.0.0.31 eq 53

permit tcp any 172.16.0.0 0.0.0.31 eq 143

permit udp any 172.16.0.0 0.0.0.31 eq 143

permit tcp any 172.16.0.0 0.0.0.31 eq 993

permit udp any 172.16.0.0 0.0.0.31 eq 993

permit tcp any 172.16.0.0 0.0.0.31 eq 110

permit udp any 172.16.0.0 0.0.0.31 eq 110

permit tcp any 172.16.0.0 0.0.0.31 eq 995

permit udp any 172.16.0.0 0.0.0.31 eq 995

permit tcp any 172.16.0.0 0.0.0.31 eq 25

permit udp any 172.16.0.0 0.0.0.31 eq 25

permit tcp any 172.16.0.0 0.0.0.31 eq 465

permit tcp any 172.16.0.0 0.0.0.31 eq 587

permit udp any 172.16.0.0 0.0.0.31 eq 587

permit tcp any 172.16.0.0 0.0.0.31 eq 443

permit eigrp any any

exit

int f0/1

ip access-group alleenPubliekeServers out
```
