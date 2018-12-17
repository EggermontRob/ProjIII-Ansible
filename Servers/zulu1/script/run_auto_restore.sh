#! /bin/sh
#--------------------------------
#Script om automatisch de config voor een pfsense machine te restoren.
#
#Auteur: Kenzie Coddens
#--------------------------------

#Exit statussen
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't mask errors in piped commands
set -o pipefail

#variabelen
#password for server root
passwd="pfsense"
#Server ip-addr
ip_addr="192.168.1.1"
#Working dir
working="$(pwd)"
#exepct loc
expect_loc="$(find $working -name "expect_scp.exp" | grep "p3ops-green")"
#Config file dir
conf_loc="$(find $working -name "config.xml" | grep "p3ops-green")"
#reboot script dir
reboot_loc="$(find $working -name "reboot.sh" | grep "p3ops-green")"

#Body
#Run het expect script
expect $expect_loc $conf_loc $reboot_loc $passwd $ip_addr