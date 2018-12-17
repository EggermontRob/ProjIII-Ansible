# ARCHIVED GEEN SAMBA4 TOCH LDAP
# Samba - Opzoeking

## Opdracht

**alfa1**  
Een domeinserver voor green.local voor gecentraliseerd beheer van gebruikers. Er zijn twee mogelijke pistes om dit te realiseren. Enerzijds via een LDAP-server (OpenLDAP, 389 Directory Server), anderzijds via een Linux-versie van de Active Directory Domain Controller (Samba 4).  
De verantwoordelijke kiest zelf welk platform gebruikt wordt.
Client-pc’s hebben geen eigen gebruikers, authenticatie gebeurt telkens via de domeinserver.  

Maak onderstaande afdelingen (groepen) aan.  
• IT Administratie  
• Verkoop  
• Administratie  
• Ontwikkeling  
• Directie  


Maak een duidelijk verschil tussen gebruikers, computers en groepen. Voeg enkele gebruikers en
minstens 5 werkstations toe (één in IT-Administratie, één in Ontwikkeling, één in Verkoop, één in
Administratie en één in Directie).


## Opzoeking
### Samba4 vs. LDAP

- Authenticated acces voor shared folders is moeilijk uit te werken via LDAP.
- Veel meer bronnen over Samba4 dan over OpenLDAP  
- Samba4 kan ook communiceren met Windows

**We hebben er als team voor gekozen om toch LDAP te gaan gebruiken in deze opdracht.**
### AD Scripts  
#### Example Script creating a new AD
```
sudo ./bin/samba-tool domain provision
Realm [EXAMPLE.COM]:
 Domain [EXAMPLE]:
 Server Role (dc, member, standalone) [dc]:
 DNS backend (SAMBA_INTERNAL, BIND9_FLATFILE, BIND9_DLZ, NONE) [SAMBA_INTERNAL]:
 DNS forwarder IP address (write 'none' to disable forwarding) [192.168.1.46]:
Administrator password:
Retype password:
Looking up IPv4 addresses
....
Fixing provision GUIDs
A Kerberos configuration suitable for Samba 4 has been generated at /opt/s4/private/krb5.conf
Once the above files are installed, your Samba4 server will be ready to use
Server Role:           active directory domain controller
Hostname:              workstation
NetBIOS Domain:        EXAMPLE
DNS Domain:            EXAMPLE.COM
DOMAIN SID:            S-1-5-21-1405516098-4140136852-3456372168
```
## Ansible roles
- [389 Directory Server](https://galaxy.ansible.com/cscfi/389-ds)
- [mrlesmithjr.samba](https://galaxy.ansible.com/mrlesmithjr/samba)

## Bronnen en Links
[Samba Wiki](https://wiki.samba.org/index.php/User_Documentation)  
[Samba vs LDAP](https://community.nethserver.org/t/samba-active-directory-or-openldap/4594)  
[What's new in Samba4](http://www.linux-magazine.com/Online/Features/What-s-New-in-Samba-4)  
[How-To-Install Samba4 on CentOS7](https://www.howtoforge.com/tutorial/samba-4-domain-controller-installation-on-centos/)  
[Github-bertvv-ansible-role-samba](https://github.com/bertvv/ansible-role-samba)  
[Github-bertvv-ansible-sambadc](https://github.com/bertvv/ansible-role-sambadc)  
[OpenLDAP Centos](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-ldap-quickstart.html)  
[Linuxtechlab](https://linuxtechlab.com/openldap-complete-guide-install-configure-ldap-centos-rhel/)  
[389 Directory Server](https://directory.fedoraproject.org/)

