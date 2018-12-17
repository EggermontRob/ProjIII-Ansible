#! /usr/bin/env bats
#
# script voor november1

#{{{ Helper Functions


#}}}
#{{{ Variables
sut=172.16.0.37
mariadb_root_password=november1
mariadb_port=3306
#}}}

@test 'The necessary packages should be installed' {
  rpm -q rh-base
  rpm -q MariaDB-server


}
@test 'The MariaDB service should be running' {
  systemctl status mariadb.service
}
@test 'The MariaDB service should be started at boot' {
  systemctl is-enabled mariadb.service
}
@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}
@test 'Web traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*mysql\b'
  
}
@test 'November1 should not have a test database' {
  run mysql -uroot -p${mariadb_root_password} --execute 'show tables' test
  [ "0" -ne "${status}" ]
}
