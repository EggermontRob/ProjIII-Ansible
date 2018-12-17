# Testrapport mike1

## Auteur(s)
- Julian Cobbaert

# Te testen onderdelen

## Alle te testen onderdelen onderverdeeld in secties:
### Test 1: Pingen

- [X] Van host naar vm 
```
C:\Users\Gebruiker>ping 172.16.0.36

Pinging 172.16.0.36 with 32 bytes of data:
Reply from 172.16.0.36: bytes=32 time<1ms TTL=64
Reply from 172.16.0.36: bytes=32 time<1ms TTL=64
Reply from 172.16.0.36: bytes=32 time<1ms TTL=64
Reply from 172.16.0.36: bytes=32 time<1ms TTL=64

Ping statistics for 172.16.0.36:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0ms, Average = 0ms
```

- [X] Van mike1 naar november1
```
[vagrant@mike1 ~]$ ping 172.16.0.37
PING 172.16.0.37 (172.16.0.37) 56(84) bytes of data.
64 bytes from 172.16.0.37: icmp_seq=1 ttl=64 time=0.725 ms
64 bytes from 172.16.0.37: icmp_seq=2 ttl=64 time=0.374 ms
64 bytes from 172.16.0.37: icmp_seq=3 ttl=64 time=0.350 ms
64 bytes from 172.16.0.37: icmp_seq=4 ttl=64 time=0.379 ms
^C
--- 172.16.0.37 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3000ms
rtt min/avg/max/mdev = 0.350/0.457/0.725/0.155 ms
```

### Test 2: Apache test page is zichtbaar

- [x] surfen naar `http://172.16.0.36/` levert de apache test page op

### Test 3: Wordpress

- [X] surfen naar `http://172.16.0.36/wordpress/` levert de wordpress page op


