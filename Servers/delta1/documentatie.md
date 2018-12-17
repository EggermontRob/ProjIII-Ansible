# Mailserver
Om de mailserver werkende te krijgen opteerden we ervoor gebruik te maken van een reeds geschreven [role](https://github.com/bertvv/ansible-role-mailserver). Hierbij worden postfix en dovecot geïnstalleerd. Om te voldoen aan de requirements betreffende antivirus en antispam, hebben we beslist de role te forken en een aantal aanpassingen te doen.
## Prerequirements
Vooraleer de installatie van de mailserver kan beginnen moet de firewall geconfigureerd worden om mailverkeer toe te laten. Ook de poorten voor HTTP en HTTPS moeten worden geopend aangezien we met een webmail gaan werken. Dit alles gebeurt via de role  [bertvv.rhbase](https://galaxy.ansible.com/bertvv/rh-base/). De benodigde parameters kunnen bekeken worden in het bestand [delta1.yml](/ansible/host_vars/delta1.yml).
## bertvv.ansoble_role_mailserver
### Postfix
Om postfix te installeren moeten er bepaalde instellingen gedefiniëerd worden. Dit gaat om instellingen zoals de hostname, het domain, de locatie van de mailboxen per gebruiker en het netwerk waarop de mailserver actief is. Ook deze instellingen kunnen worden bekeken in het bestand [delta1.yml](/ansible/host_vars/delta1.yml).
### Dovecot
Dovecot vergt geen specifieke parameters meer in deze role. Er worden echter wel enkele configuratiebestanden gekopieerd zodat alles werkende is met de instellingen die zijn opgegeven voor postfix.
## Aanpassingen
### Postfix
Om postfix 100% werkende te krijgen hebben we enkele zaken aangepast. Ten eerste werd er in het bestand `/etc/postfix/local-host-names` de regel `green.local` toegevoegd. Dit geeft postfix aan dat het uitgaande verkeer van green.local toegestaan is. 

Daarnaast hebben we ook een een parameter toegevoegd om de netwerken van postfix mee te geven. Dit zijnde de parameter `postfix_mynetwork`.

Tenslotten voorziet de role nu ook functionaliteit binnen LDAP netwerken. 
### Dovecot
In de configuratie van Dovecot hebben we slechts 1 iets aangepast. Dit zijnde een oplossing voor het probleem waardoor de connectie via Thunderbird niet goed verliep. We hebben hiervoor de lijn `imap_client_workarounds = tb-extra-mailbox-sep` toegevoegd aan het bestand `20-imap.conf` in de Dovecot directory.
### ClamAV
ClamAV hebben we aan de role toegevoegd. ClamAV is een open source anti-virus mechanisme dat gebruikt wordt in verschillende situaties, maar voornamelijk bij web scanning en mail scanning.

Om dit pakket werkende te krijgen worden volgende packages geïnstalleerd: 
- clamav-server
- clamav-data
- clamav-update
- clamav-filesystem
- clamav
- clamav-scanner-systemd
- clamav-devel
- clamav-lib
- clamav-server-systemd

Nadien wordt het configuratiebestand gekopieerd anar de desbetreffende map om nadien de service te starten.
### SpamAssasin
Om SpamAssasin werkende te krijgen volstaat het het pakket `spamassassin` te installeren. Nadien wordt het configuratiebestand lichtjes aangepast zodat het voldoet aan onze wensen. Tenslotten starten we de service en doen we een update van de spam definities. 

SpamAsassin heeft ook een gebruiker nodig (spamd). Deze wordt helemaal aan het einde van de role aangemaakt.
## Extra feature
### Squirrelmail
