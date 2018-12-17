#! /usr/bin/env bats
#
# Testscript for 389-DS
# De LDAP install en config wordt getest

sut_ip=172.16.0.3

#{{{ Helper functions

#}}}

@test 'De ldap client tools moeten geïnstalleerd zijn.' {
  which ldapsearch
  which ldapwhoami
}

@test 'Er verbonden worden met LDAP met user "admin" en wachtwoord "password".' {
  ldapwhoami -x -w "ldapadmin" -D "cn=admin"
}

@test 'De gewenste users bevinden zich in de LDAP database.' {
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=ismail" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=lennert" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=rob" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=robin" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=thomas" | grep "dn:"
}

@test 'De gewenste users bevinden zich in de LDAP database.' {
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=ismail" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=thomas" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=rob" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=robin" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "uid=lennert" | grep "dn:"
}

@test "Wachtwoord van alle users is Test123" {
  ldapwhoami -x -w "Test123" -D "uid=ismail,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=thomas,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=rob,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=robin,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "Test123" -D "uid=lennert,ou=People,dc=green,dc=local"
}

@test  'De gewenste groepen bevinden zich in de LDAP database.' {
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=itadministratie" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=verkoop" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=administratie" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=ontwikkeling" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w ldapadmin "cn=directie" | grep "dn:"
}
