#! /usr/bin/env bats
#
# Acceptance test for the DNS server for linuxlab.lan

sut_ip=172.16.0.5
master_dns=172.16.0.4
domain=green.local

#{{{ Helper functions

# Usage: assert_forward_lookup NAME IP
# Exits with status 0 if NAME.DOMAIN resolves to IP, a nonzero
# status otherwise
assert_forward_lookup() {
  local name="$1"
  local ip="$2"

  [ "$ip" = "$(dig @${sut_ip} ${name}.${domain} +short)" ]
}

# Usage: assert_reverse_lookup NAME IP
# Exits with status 0 if a reverse lookup on IP resolves to NAME,
# a nonzero status otherwise
assert_reverse_lookup() {
  local name="$1"
  local ip="$2"

  [ "${name}.${domain}." = "$(dig @${sut_ip} -x ${ip} +short)" ]
}

# Usage: assert_alias_lookup ALIAS NAME IP
# Exits with status 0 if a forward lookup on NAME resolves to the
# host name NAME.DOMAIN and to IP, a nonzero status otherwise
assert_alias_lookup() {
  local alias="$1"
  local name="$2"
  local ip="$3"
  local result="$(dig @${sut_ip} ${alias}.${domain} +short)"

  echo ${result} | grep "${name}\.${domain}\."
  echo ${result} | grep "${ip}"
}

# Usage: assert_ns_lookup NS_NAME...
# Exits with status 0 if all specified host names occur in the list of
# name servers for the domain.
assert_ns_lookup() {
  local result="$(dig @${sut_ip} ${domain} NS +short)"

  [ -n "${result}" ] # the list of name servers should not be empty
  while (( "$#" )); do
    echo "${result}" | grep "$1\.${domain}\."
    shift
  done
}

# Usage: assert_mx_lookup PREF1 NAME1 PREF2 NAME2...
#   e.g. assert_mx_lookup 10 mailsrv1 20 mailsrv2
# Exits with status 0 if all specified host names occur in the list of
# mail servers for the domain.
assert_mx_lookup() {
  local result="$(dig @${sut_ip} ${domain} MX +short)"

  [ -n "${result}" ] # the list of name servers should not be empty
  while (( "$#" )); do
    echo "${result}" | grep "$1 $2\.${domain}\."
    shift
    shift
  done
}

#}}}

@test 'The `dig` command should be installed' {
  which dig
}

@test 'The main config file should be syntactically correct' {
  named-checkconf /etc/named.conf
}

@test 'The server should be set up as a slave' {
  result=$(grep 'type slave' /etc/named.conf)
  [ -n "${result}" ]
  result=$(run grep 'type master' /etc/named.conf)
  [ -z "${result}" ]
}

@test 'The server should forward requests to the master server' {
  result=$(grep 'masters' /etc/named.conf | fgrep "${master_dns}" )
  [ -n "${result}" ]
}

@test 'There should not be a forward zone file' {
  # It is assumed that the name of the zone file is the name of the zone
  # itself (without extra extension)
  [ ! -f /var/named/${domain} ]
}

@test 'The service should be running' {
  systemctl status named
}

@test 'Forward lookups private servers' {
  #                     host name   IP
  assert_forward_lookup alfa1      172.16.0.3
  assert_forward_lookup bravo1      172.16.0.4
  assert_forward_lookup charlie1    172.16.0.5
  assert_forward_lookup delta1      172.16.0.6
  assert_forward_lookup echo1       172.16.0.7
  assert_forward_lookup kilo1       172.16.0.34
  assert_forward_lookup lima1       172.16.0.35
  assert_forward_lookup mike1       172.16.0.36
  assert_forward_lookup november1   172.16.0.37
  assert_forward_lookup oscar1      172.16.0.38
  assert_forward_lookup papa1       172.16.0.39
  assert_forward_lookup quebec1     172.16.0.40
}

@test 'Reverse lookups public servers' {
  #                     host name   IP
  assert_reverse_lookup alfa1      172.16.0.3
  assert_reverse_lookup bravo1      172.16.0.4
  assert_reverse_lookup charlie1    172.16.0.5
  assert_reverse_lookup delta1      172.16.0.6
  assert_reverse_lookup echo1       172.16.0.7
  assert_reverse_lookup kilo1       172.16.0.34
  assert_reverse_lookup lima1       172.16.0.35
  assert_reverse_lookup mike1       172.16.0.36
  assert_reverse_lookup november1   172.16.0.37
  assert_reverse_lookup oscar1      172.16.0.38
  assert_reverse_lookup papa1       172.16.0.39
  assert_reverse_lookup quebec1     172.16.0.40
}

@test 'Alias lookups public servers' {
   #                  alias     host name   IP
  assert_alias_lookup dc        alfa1      172.16.0.3
  assert_alias_lookup ns1       bravo1      172.16.0.4
  assert_alias_lookup ns2       charlie1    172.16.0.5
  assert_alias_lookup mail      delta1      172.16.0.6
  assert_alias_lookup www       echo1       172.16.0.7
  assert_alias_lookup dhcp      kilo1       172.16.0.34
  assert_alias_lookup ftp       lima1       172.16.0.35
  assert_alias_lookup cms       mike1       172.16.0.36
  assert_alias_lookup db        november1   172.16.0.37
  assert_alias_lookup monitor   oscar1      172.16.0.38
  assert_alias_lookup pxe       papa1       172.16.0.39
}

@test 'NS record lookup' {
  assert_ns_lookup bravo1 charlie1
}

@test 'Mail server lookup' {
  assert_mx_lookup 10 delta1
}
