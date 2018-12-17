# End - to - end testing tussen delta1 (Mailserver) , bravo1 (dns) , charlie1 (backup dns) , quebec1 (forwarding dns)

## Inleiding

Een hostsysteem/server probeert verbinding te maken met 
- www.flair.be
- Server (vb bravo1)

### DNS van lokale naam naar ip-adres. (Commando's voor delta) 

```
nslookup bravo1 172.16.0.40
```

Systeem zoekt welk ip-adres bravo1 heeft via de forwarding DNS. Deze is lokaal dus vraagt hij dit
aan de DNS-server bravo1. Indien deze niet actief is vraagt hij dit aan de DNS-Server Charlie1.

Er is volgende output : 

![image](https://user-images.githubusercontent.com/25976107/47286614-bc6d9b80-d5ef-11e8-98b5-216fc1350652.png)


### DNS van website naar ip-adres.

```
nslookup www.flair.be 172.16.0.40
```

Systeem zoekt welk ip-adres www.flair.be heeft via de forwarding DNS. (172.16.0.40) 

Er is volgende output : 

![image](https://user-images.githubusercontent.com/25976107/47286645-e030e180-d5ef-11e8-886e-5c4ad91e3593.png)

#### Testing in console van quebec1.

Voor bovenstaand commando kan er ook output verkregen worden in de console van quebec1.
Start quebec1 op via 
```
vagrant up quebec1 // vagrant provision quebec1
```

SSH in de server
```
vagrant ssh quebec1
```

In de console : 
```
sudo -i
```

Daarna het volgende commando : 
```
tcpdump -i any udp port 53 -n
```

!!! Let op : Er moeten dus 2 console vensters zijn : 1 voor delta , 1 voor quebec. (Deze van bravo op de screenshot mag genegeerd worden)
