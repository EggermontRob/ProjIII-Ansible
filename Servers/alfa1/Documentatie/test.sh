# Test commando'#!/bin/sh
# Je kan deze commando's gebruiken om alles te Testen
# user en groepen slagen reeds, wachtwoord check nog niet
  ldapwhoami -x -w "ldapadmin" -D "cn=admin"


echo'De gewenste users bevinden zich in de LDAP database.'
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=ismail" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=thomas" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=rob" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=robin" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=lennert" | grep "dn:"

echo "Wachtwoord van alle users is Test123"
  ldapwhoami -x -w "Test123" -D "uid=ismail,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=thomas,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=rob,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=robin,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=lennert,ou=People,dc=green,dc=local"


echo 'De gewenste groepen bevinden zich in de LDAP database.'
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=itadministratie" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=verkoop" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=administratie" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=ontwikkeling" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=directie" | grep "dn:"
