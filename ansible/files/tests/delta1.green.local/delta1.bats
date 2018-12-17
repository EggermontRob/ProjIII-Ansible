#! /usr/bin/env bats
#
# script voor november1

#{{{ Helper Functions


#}}}
#{{{ Variables
sut=172.16.0.6
#}}}

@test 'The necessary packages should be installed' {
  rpm -q doveot
  rpm -q postfix
  rpm -q spamassassin
  rpm -q clamav-server
  rpm -q clamav-data
  rpm -q clamav-update
  rpm -q clamav-filesystem
  rpm -q clamav
  rpm -q clamav-scanner-systemd
  rpm -q clamav-devel
  rpm -q clamav-lib
  rpm -q clamav-server-systemd


}
@test 'The Postfix service should be running' {
  systemctl status postfix.service
}
@test 'The Dovecot service should be running' {
  systemctl status dovecot.service
}
@test 'The ClamAV service should be running' {
  systemctl status clamd@scan.service
}
@test 'The spamassassin service should be running' {
  systemctl status spamassassin.service
}
@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}
@test 'Mail traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*imap\b'
  firewall-cmd --list-all | grep 'services.*imaps\b'
  firewall-cmd --list-all | grep 'services.*pop3\b'
  firewall-cmd --list-all | grep 'services.*smtp\b'
  firewall-cmd --list-all | grep 'services.*smtps\b'
  firewall-cmd --list-all | grep 'services.*smtp-submussion\b'
}
@test 'Web traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*https\b'
}