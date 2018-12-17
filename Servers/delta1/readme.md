# Installatie MailServer
## Systeeminformatie
Hostname: mail.green.local  
IP: 

## DNS
Voor een mailserver is er een DNS server nodig. Daarom overlopen we eerst de stappen die moeten voltooid worden vooraleer een mailserver geïnstalleerd kan worden.  
**DNS records:**  

|Type |Host |Destination |Priority |TTL |
|-------|--------|------------------------|-----------|----|
|MX     |@       |mail.green.local        |10         |3600|
|A      |mail    |{{IP-addrss}}           |           |3600|

## Postfix
