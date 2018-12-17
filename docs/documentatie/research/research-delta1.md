# Mailserver - Documentatie

## delta1 
### Opdracht
Een mailserver (gebaseerd op Postfix) met SMTP en IMAP. Het moet mogelijk zijn mails te versturen en te ontvangen tussen de twee domeinen. Gebruikers in de directory server hebben ook een mailbox. Deze mailserver past ook anti-spam en anti-virus technieken toe.

## Opzoeking
### Postfix
Postfix is een opensource SMTP-mailserver. 
#### Configuratiebestanden
| Key 	| Betekenis 	|
|---	|---	|
| myhostname 	| Hostname van de machine 	|
| mydomain 	| Domein waarop postfix moet werken 	|
| myorigin 	| Het domein 	|
| home_mailbox 	| Locatie waar mailbox moet opgeslagen worden 	|
| mynetworks 	| Netwerk van postfix 	|
| inet_interfaces 	| Op welke interfaces postfix moet werken 	|
| mydestination 	| Geeft aan welke domeinen lokaal afgeleverd moeten worden, in paats van online 	|
| smtpd_sasl_type 	| Implementatie specifieke informatie die postfix doorgeeft aan de SASL plugin 	|
| smtpd_sasl_path 	| Pad van Cyrus SASL configuratie bestanden 	|
| smtpd_sasl_local_domain 	| Naam van postfix lokale SASL domein (standaard leeg) 	|
| smtpd_sasl_security_options 	| SASL beveiligingsoptie (standaard noanonymous) 	|
| broken_sasl_auth_clients 	| interoperabiliteit inschakelen met externe SMPT clients   |
| smtpd_sasl_auth_enable 	| Schakelt SASL authenticatie in op de SMTP server (standaard no) 	|
| smtpd_recipient_restrictions 	| Optionele restricties die postfix toepast 	|
| smtp_tls_security_level 	| Standaard TSL beveiligingsniveau (standaard leeg) 	|
| smtpd_tls_security_level 	| Standaard TSL beveiligingsniveau (standaard leeg) 	|
| smtp_tls_note_starttls_offer 	| Log de hostnaam van de externe SMTP server dat STARTTSL biedt, wanneer TSL nog niet geactiveerd is voor die server 	|
| smtpd_tls_loglevel 	| Niveau waarop gelogd moet worden 	|
| smtpd_tls_key_file 	| Locatie van de sleutel van het TSL server certificaat 	|
| smtpd_tls_cert_file 	| Locatie van het TSL server certificaat 	|
| smtpd_tls_session_cache_timeout 	| The expiration time of Postfix SMTP server TLS session cache information 	|
| tls_random_source 	| * 	|         
### Dovecot 
Dovecot is een opensource IMAP en POP3 mailserver voor Linux en UNIX gebaseerde systemen. 

### Anti-spam / Anti-virus

# SpamAssassin en ClamAV

SpamAssassin werkt tussen de buitenwereld en de services dat draaien op de sever.

## Installatie 
De installatie gaat via volgend commando
```
yum install spamassassin
```
De main conf file staat op het path */etc/mail/spamassassin/local.cf*, deze zou conf file zou volgende data moeten bevatten
```
report_safe 0
required_score 8.0
rewrite_header Subject [SPAM]
```

- **report_safe** Als de waarde van dit op *0* staat (wat aan te raden is) zal de inkomende spam mail niet verwijderd worden enkel de headers zullen aangepast worden. Staat de waarde echter op *1* zal de spam mail verwijderd worden.
- **required_score** hiermee kan je installen hoe agressief deze spam server moet zijn. dit zullen altijd decimale getallen zijn. Aanteraden is tussen de 8 en de 10

Een volgende stap is het starten/enablen van de SpamAssassin opzich, dit gebuerd via de gekende commandos.
```
systemctl enable spamassassin
systemctl start spamassassin
```

Het is ook wenselijk om de repo's up to date te brengen via het commando
```
sa-update
```

Om SpamAssassin efficient te laten draaien op een Postfix mail server, zullen we een gebruiker moeten aanmaken waarop de deamon zal draaien.
```
useradd spamd -s /bin/false -d /var/log/spamassassin
```

Nadat we dit hebben gedaan zullen we dit wel moeten laten weten aan de postfix, dit gebuerd door de onderstaande lijn toe te voegen aan de conf file van SpamAssassin (*/etc/postfix/master.cf*). in dezelfde file zal je boven aan zien staan dat smtp uit commentaar staat. zorg er voor dat achter aan bij **-o content_filter=spamassassin** staat. Is dit nog niet het geval, pas dit dan aan.  
**Note** een restart van de service postfix is nodig
```
spamassassin unix - n n - - pipe flags=R user=spamd argv=/usr/bin/spamc -e /usr/sbin/sendmail -oi -f ${sender} ${recipient}
```

## Testen van spamassassin

Om te testen of de service van spamassassin goed werkt, gaan we dit testen met **GTUBE** *(Generic Test for Unsolicited Bulk Email)*.  
Deze GTUBE bericht gaat als het volgend in zijn werking,er moet een mail verzonden worden die uit het netwerk ligt (via gmail, hotmail,  enzoverder...). De title van dit bericht is zelf te kiezen, wat wel belangrijk is, is de body van het bericht. Dit vul je op met
```
XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X
```
Eens de mail verzonden, kunnen we contoleren of dit bericht gedetecteerd is als spam, dit doen gebuerd via volgend commando
```
journalctl | grep spam
```
Als je hierin kijkt zie je dat de mail gedetecteerd is als spam met spam score van 1002.3 en een required van 8 (zoals ingesteld).
Een andere test voer je uit met
```
spamassassin -D < /usr/share/doc/spamassassin-3.4.0/sample-spam.txt
```

Hierbij vind je alle details terug van het bericht zoals de title, en body.  
**Note** moesten er problemen zijn met deze testen zou het aangeraden om [deze](https://wiki.apache.org/spamassassin/AskingAboutIntegrations) handleiding te lezen.

## Het starten van ClamAV en aanmaken van Virus Definitions

Om ClamAV te kunnen gebruiken , installeren we dit eerst

```
yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
```
Om te beginnen zullen er een paar zaken moeten worden aanpassen in */etc/clamd.d/scan.conf*
```
LocalSocket /var/run/clamd.scan/clamd.sock
```
 - Moet niet in commentaar
```
Example
```
- zou wel in commentaar moeten komen.

Hierna moeten de service's gestarten worden en enable'd met de gekende commando's
```
systemctl enable clamd@scan.service
systemctl start clamd@scan.service
```

**Note** vergeet niet de *antivirus_can_scan_system SELinux boolean* op 1 te zetten
```
setsebool -P antivirus_can_scan_system 1
```

In theorie zou alles nu moeten werken, maar het zal niet goed werken, als je gaat kijken naar de status van de service zal je merken dat deze niet update zal lopen. Om deze zaken up to date te houden zullen we werken met de tool **freshclam** (deze werdt geinstaleerd bij clamav-update package)

Ja kan deze zaken update door een Cron job te schrijven. Deze job zal de service van data tot tijd updaten.  
```
00 10 * * * root /usr/share/clamav/freshclam-sleep
```
In bovenstaande voorbeeld zullen de virus definitions elke dag om 10 am server tijd worden geupdate.  
**Note** als u graag meer wilt meer weten over cron job's, is [deze](https://www.tecmint.com/11-cron-scheduling-task-examples-in-linux/) handleiding zeker een goed begin begin om te lezen.  

Een andere optie is het om het gewoon handmatige te updaten, dit gebeurd via het commando
```
freshclam
```
Let wel op , deze zal enkel werken als *Example* in de file */etc/freshclam.conf* hebt afgezet anders zal dit niet werken.

## Testen van ClamAV

Om te testen of dit werkt naar behoren moeten we een virus simulatie opzetten. Deze simulator gaat zich gedragen als een bijlage van een mail dat een virus bevat Een simulator die we aanraden is
```
wget http://www.eicar.org/download/eicar.com
```
Daarna kunnen we testen of deze file wordt gedetecteerd als virus.
Dit doen we door volgend commando
```
clamscan --infected --remove --recursive [en het gewenste path]
```

Hiervan kun je een cronjob maken en steeds laten uitvoeren.  
vergeet in deze job zeker geen logpath toetevoegen

## Ansible roles
- [bertvv.mailserver](https://galaxy.ansible.com/bertvv/mailserver/) 

## Bronnen en Links
[Postfix Documentatie Site](http://www.postfix.org/documentation.html)  
[Dovecot Documentatie site](https://wiki2.dovecot.org)  s
[Role documentatie](https://github.com/bertvv/ansible-role-mailserver/blob/master/README.md)  
[Postfix Conf](http://www.postfix.org/postconf.5.html)  
[SpamAssassin en ClamAV installatie](https://www.tecmint.com/integrate-clamav-and-spamassassin-to-protect-postfix-mails-from-viruses/)  
[Cron jobs](https://www.tecmint.com/11-cron-scheduling-task-examples-in-linux/)  
[wiki spamassassin](https://wiki.apache.org/spamassassin/AskingAboutIntegrations)  
https://hostpresto.com/community/tutorials/how-to-install-clamav-on-centos-7/  
https://www.packtpub.com/mapt/book/networking_and_servers/9781785282393/9/ch09lvl1sec67/installing-and-configuring-spamassassin  
