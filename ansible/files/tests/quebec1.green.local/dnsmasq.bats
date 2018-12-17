#! /usr/bin/env bats
#
# Acceptance test for the DNS server for linuxlab.lan

sut_ip=172.16.0.40
domain=green.local


# {{{ Helper functions

# Usage: assert_forward_lookup NAME IP
# Exits with status 0 if NAME.DOMAIN resolves to IP, a nonzero
# status otherwise
assert_forward_lookup() {
  local name="$1"
  local ip="$2"

  [ "$ip" = "$(dig @${sut_ip} "${name}.${domain}" +short)" ]
}

# Usage: assert_reverse_lookup NAME IP
# Exits with status 0 if a reverse lookup on IP resolves to NAME,
# a nonzero status otherwise
assert_reverse_lookup() {
  local name="$1"
  local ip="$2"
  local result
  result=$(dig @${sut_ip} -x "${ip}" +short)

  [ "${name}.${domain}." = "${result}" ]
}

# Usage: assert_alias_lookup ALIAS NAME IP
# Exits with status 0 if a forward lookup on NAME resolves to the
# host name NAME.DOMAIN and to IP, a nonzero status otherwise
assert_alias_lookup() {
  local alias="$1"
  local name="$2"
  local ip="$3"
  local result
  result=$(dig @${sut_ip} "${alias}.${domain}" +short)

  echo "${result}" | grep "${name}\.${domain}\."
  echo "${result}" | grep "${ip}"
}

# Usage: assert_ns_lookup NS_NAME...
# Exits with status 0 if all specified host names occur in the list of
# name servers for the domain.
assert_ns_lookup() {
  local result
  result=$(dig @${sut_ip} ${domain} NS +short)

  [ -n "${result}" ] # the list of name servers should not be empty
  while (( "$#" )); do
    echo "${result}" | grep "$1\.${domain}\."
    shift
  done
}


#}}}

@test 'The `nslookup` command should be installed' {
  which nslookup
}

@test 'The `dig` command should be installed' {
  which dig
}

@test 'The service should be running' {
  systemctl status dnsmasq.service
}

@test 'Forward lookups private servers' {
  #                     host name  IP
  assert_forward_lookup alfa1      172.16.0.3
  assert_forward_lookup bravo1     172.16.0.4
  assert_forward_lookup charlie1   172.16.0.5
  assert_forward_lookup delta1     172.16.0.6
  assert_forward_lookup echo1      172.16.0.7
  assert_forward_lookup kilo1      172.16.0.34
  assert_forward_lookup lima1      172.16.0.18
  assert_forward_lookup mike1      172.16.0.36
  assert_forward_lookup november1  172.16.0.37
  assert_forward_lookup oscar1     172.16.0.38
  assert_forward_lookup papa1      172.16.0.39

}

@test 'Reverse lookups private servers' {
  #                     host name  IP
  assert_reverse_lookup alfa1           172.16.0.3
  assert_reverse_lookup bravo1          172.16.0.4
  assert_reverse_lookup charlie1        172.16.0.5
  assert_reverse_lookup delta1          172.16.0.6
  assert_reverse_lookup echo1           172.16.0.7
  assert_reverse_lookup kilo1           172.16.0.34
  assert_reverse_lookup lima1           172.16.0.18
  assert_reverse_lookup mike1           172.16.0.36
  assert_reverse_lookup november1       172.16.0.37
  assert_reverse_lookup oscar1          172.16.0.38
  assert_reverse_lookup papa1           172.16.0.39
}


@test 'Alias lookups private servers' {
  #                      alias      hostname        IP
  assert_alias_lookup dc          alfa1           172.16.0.3
  assert_alias_lookup ns1         bravo1          172.16.0.4
  assert_alias_lookup ns2         charlie1        172.16.0.5
  assert_alias_lookup mail        delta1          172.16.0.6
  assert_alias_lookup www         echo1           172.16.0.7
  assert_alias_lookup dhcp        kilo1           172.16.0.34
  assert_alias_lookup ftp         lima1           172.16.0.18
  assert_alias_lookup cms         mike1           172.16.0.36
  assert_alias_lookup db          november1       172.16.0.37
  assert_alias_lookup monitor     oscar1          172.16.0.38
  assert_alias_lookup pxe         papa1           172.16.0.39

}

#Kijken welke servers DNS zijn
@test 'NS record lookup' {
  assert_ns_lookup bravo1 charlie1
}
