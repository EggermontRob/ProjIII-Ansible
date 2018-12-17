#! /usr/bin/env bats
#
# Original Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
# Adjusted by: Thibo Van den Bossche, Niel De Boever
#
# Test the pxeserver
@test 'The necessary packages should be installed' {
  rpm -q tftp
  rpm -q tftp-server
  rpm -q syslinux
  rpm -q vsftpd
  rpm -q xinetd


}
@test 'The xinetd service should be running' {
  systemctl status xinetd.service
}


@test 'The tftp service should be running' {
  systemctl status vsftpd.service
}

@test 'Necessary services should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*tftp\b'
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*https\b'
}
