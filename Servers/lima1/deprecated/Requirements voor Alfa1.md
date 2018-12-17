Note: niet meer nuttig
# Requirements voor de fileserver op Alfa1
 ### Stap 1:
Zet alfa1 op zoals beschreven in de documentatie
 ### Stap 2:
Installeer samba en smbldap-tools: `sudo yum install samba smbldap-tools`
 ### Stap 3:
Voer het volgende commando uit:
```
perl /usr/share/doc/samba-4.7.1/LDAP/ol-schema-migrate.pl -b /usr/share/doc/samba-4.7.1/LDAP/samba.schema > /etc/dirsrv/slapd-alfa1/schema/61samba.ldif
```
Dit zal het samba schema installeren op de juiste plaats.
### Stap 4:
Restart de AD server:
```
 systemctl restart dirsrv.target
 systemctl restart dirsrv-admin
```
 ### Stap 5:
Open `/etc/sudo-ldap.conf` en voeg onderstaande lijnen toe:
```
uri ldap://alfa1.green.local
ldap_version 3
pam_password md5
host 127.0.0.1
base dc=green,dc=local
binddn uid=admin,ou=Administrators,ou=TopologyManagement,o=NetscapeRoot
bindpw ldapadmin
port 389
```
 ### Stap 6:
Kopieër sudo-ldap.conf en noem het ldap.conf: `cp /etc/sudo-ldap.conf /etc/ldap.conf`
 Note: Deze stap is voor de zekerheid en kan zeker geen kwaad.
 ### Stap 7:
Open `/etc/openldap/ldap.conf` en voeg het volgende toe:
```
BASE    dc=green,dc=local
URI     ldap://alfa1.green.local
```
 ### Stap 8:
Done.
