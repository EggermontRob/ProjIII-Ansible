# Testing while installing LDAP server

- [x] Provisioning scripted
- [x] LDAP install scripted

## 17/10/2018 14u LDAP install is failing
Errors generated:
```
Are you ready to set up your servers? [yes]: Creating directory server . . .
Your new DS instance 'alfa1' was successfully created.
Creating the configuration directory server . . .
Error: failed to open an LDAP connection to host 'alfa1.green.local' port '389' as user 'cn=Directory Manager'.  Error: unknown.
Failed to create the configuration directory server
Exiting . . .
```

**Reason:** Unknown

## 17/10/2018 20u LDAP INSTALL PASSED
**Problem solved**

## 18/10/2018 LDAP Install fully completed

## Checking wheter the server is installed correct
- `systemctl | grep dirsr`
Output should be like this:
```
[root@alfa1 vagrant]# systemctl | grep dirsrv
  dirsrv-admin.service                                                                    loaded active running   389 Administration Server.
  dirsrv@alfa1.service                                                                     loaded active running   389 Directory Server alfa1.
  system-dirsrv.slice                                                                      loaded active active    system-dirsrv.slice
  dirsrv.target                                                                            loaded active active    389 Directory Server

```
- Confif file: `/etc/dirsrv/admin-serv/`

## 2/11/2018 LDAP User Login

Alle users and groups worden aangemaakt en gezien door de DS.
Maar er kan niet worden aangemeld met deze users, door een onbekende reden.

Het script staat in de home directory, moet nog worden uitgevoerd.
./config.sh






### Source:
  - [Admin Server](https://directory.fedoraproject.org/docs/389ds/administration/adminserver.html?fbclid=IwAR2ZlE_J6EOG4DDV7cvlXMVcWY-7JTlN2n1I8lQw918mnFTKD1fj0wcRMOo)
