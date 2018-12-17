#!/bin/bash

# Author:
#		   Ismail El Kaddouri


set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Colors
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'		 #No Color

echo -e ${CYAN}"Configuration of 389-DS users and groups"${NC}

#Deleting standard users and groups
#Deleting users
ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "cn=HR Managers,ou=Groups,dc=green,dc=local"
ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "cn=QA Managers,ou=Groups,dc=green,dc=local"
ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "cn=PD Managers,ou=Groups,dc=green,dc=local"
ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "cn=Accounting Managers,ou=Groups,dc=green,dc=local"
#Groepen
#ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "ou=Groups,dc=green,dc=local"
#ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "ou=People,dc=green,dc=local"
ldapdelete -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x "ou=Special Users,dc=green,dc=local"
echo -e ${GREEN}"Default users and groups are deleted"${NC}

#Adding Groups
#rm /tmp/groups.ldif
touch /tmp/groups.ldif

echo "
dn: cn=itadministratie,ou=Groups,dc=green,dc=local
objectclass: top
objectclass: posixGroup
cn: itadministratie
gidnumber: 600
memberuid: 700

dn: cn=administratie,ou=Groups,dc=green,dc=local
objectclass: top
objectclass: posixGroup
cn: administratie
gidnumber: 601
memberuid: 701

dn: cn=verkoop,ou=Groups,dc=green,dc=local
objectclass: top
objectclass: posixGroup
cn: verkoop
gidnumber: 602
memberuid: 702

dn: cn=ontwikkeling,ou=Groups,dc=green,dc=local
objectclass: top
objectclass: posixGroup
cn: ontwikkeling
gidnumber: 603
memberuid: 703

dn: cn=directie,ou=Groups,dc=green,dc=local
objectclass: top
objectclass: posixGroup
cn: ontwikkeling
gidnumber: 604
memberuid: 604

" > /tmp/groups.ldif
echo -e ${GREEN}"Default groups are declared in ldif file"${NC}
ldapadd -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x -f /tmp/groups.ldif
echo -e ${GREEN}"green.local groups are pushed to server"${NC}

#Adding Users
#rm /tmp/users.ldif
touch /tmp/users.ldif

# Wachtwoord voor elke user is "Test123"

echo "
dn: uid=ielkaddouri,ou=People,dc=green,dc=local
cn: Ismail El Kaddouri
sn: El Kaddouri
objectclass: top
objectclass: person
objectclass: posixAccount
objectclass: shadowAccount
uid:ismail
userPassword:{SSHA}In1mmJUoHA+5AlojK2eGP6FRN5mLUqt9rLMjOg==
uidNumber:700
gidNumber:700
gecos:Ismail El Kaddouri
loginShell:/bin/bash
homeDirectory:/home/ismail

dn: uid=tvandeveire,ou=People,dc=green,dc=local
cn: Thomas Vandeveire
sn: Vandeveire
objectclass: top
objectclass: person
objectclass: posixAccount
objectclass: shadowAccount
uid:thomas
userPassword:{SSHA}In1mmJUoHA+5AlojK2eGP6FRN5mLUqt9rLMjOg==
uidNumber:701
gidNumber:701
gecos:Thomas Vandeveire
loginShell:/bin/bash
homeDirectory:/home/thomas

dn: uid=rdecock,ou=People,dc=green,dc=local
cn: Robin De Cock
sn: De Cock
objectclass: top
objectclass: person
objectclass: posixAccount
objectclass: shadowAccount
uid:robin
userPassword:{SSHA}In1mmJUoHA+5AlojK2eGP6FRN5mLUqt9rLMjOg==
uidNumber:702
gidNumber:702
gecos: Robin De Cock
loginShell:/bin/bash
homeDirectory:/home/robin

dn: uid=reggermont,ou=People,dc=green,dc=local
cn: Rob Eggermont
sn: Eggermont
objectclass: top
objectclass: person
objectclass: posixAccount
objectclass: shadowAccount
uid:rob
userPassword:{SSHA}In1mmJUoHA+5AlojK2eGP6FRN5mLUqt9rLMjOg==
uidNumber:703
gidNumber:703
gecos: Rob Eggermont
loginShell:/bin/bash
homeDirectory:/home/rob

dn: uid=lmertens,ou=People,dc=green,dc=local
cn: Lennert Mertens
sn: Mertens
objectclass: top
objectclass: person
objectclass: posixAccount
objectclass: shadowAccount
uid:lennert
userPassword:{SSHA}In1mmJUoHA+5AlojK2eGP6FRN5mLUqt9rLMjOg==
uidNumber:704
gidNumber:704
gecos: Lennert Mertens
loginShell:/bin/bash
homeDirectory:/home/lennert
" > /tmp/users.ldif
echo -e ${GREEN}"Default groups are declared in ldif file"${NC}
ldapadd -D "cn=admin" -w ldapadmin -p 389 -h alfa1.green.local -x -f /tmp/users.ldif
echo -e ${GREEN}"green.local users are pushed to server"${NC}

echo -e ${PURPLE}"directory server is being restarted"${NC}
service dirsrv@alfa1 restart
echo -e ${PURPLE}"directory server is restarted"${NC}
#run Perl script to recreate the index
#db2index.pl -Z dirsrv-alfa1 -D "cn=admin" -w ldapadmin -n userRoot
