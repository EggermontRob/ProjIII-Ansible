# Installatie

* Installatie via yum

`yum install openldap openldap-clients openldap-servers -y`

* OpenLDAP password aanmaken voor administrators

`slappasswd`

* openLDAP starten

`systemctl start sldapd`

* openLDAP enablen zodat het opstart bij het opstarten van het systeem

`systemctl enable sldapd`

# Configuratie

* Configuratiebestand bewerken

`vi /etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif`

    Wijzigingen:
    olcSuffix: dc=domein,dc=local
    olcRootDN: cn=Manager,dc=domein,dc=local



# 389 GUI opstarten
naar /p3g
 'ssh -X vagrant@alfa1'
'password: vagrant'
 '389-console'

Login 389-console:
username: admin
password: ldapadmin
server: http://localhost:9830

Standaard worden enkele groups aangemaakt, die wij dan verwijderen
- Accounting Managers
- HR Managers
- QA Managers
- PD Managers
- Directory Administrators

Ook de standaard aangemaakt OU's verwijderen
People, Groups,Special Users

Dit doe je door het config script uit te voeren
/data/config.sh
