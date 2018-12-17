#!/bin/sh
#-------------------------------------------------------------------------------
#Script om pfSense config te kopieren naar pfSense VM.
#Script moet uitgevoerd worden op host.
#
#Auteur: Kenzie Coddens
#-------------------------------------------------------------------------------

#Exit statussen
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't mask errors in piped commands
set -o pipefail

#Working dir
working="$(pwd)"
echo $working

#Config file dir
conf_loc="$(find $working -name "config.xml" | grep "p3ops-green")"
echo $conf_loc

#reboot script dir
reboot_loc="$(find $working -name "reboot.sh" | grep "p3ops-green")"
echo $reboot_loc

#key locatie
#key_loc="$(find / -name "authorized_keys")"
#echo $key_loc

#passwd file loc
#passwd_loc="$(find / -name "Zulu1_passwd_1")"
#echo $passwd_loc

#sshpass -f $passwd_loc scp $conf_loc root@172.16.0.70:/cf/conf/

#ssh copy
#scp $key_loc root@172.16.0.70:/root/.ssh/
#sshpass -f $passwd_loc scp $conf_loc root@172.16.0.70:/cf/conf/
#sshpass -f $passwd_loc scp $reboot_loc root@172.16.0.70:/tmp/
#sshpass -f $passwd_loc ssh root@172.16.0.70 '/tmp/reboot.sh'

#curl -T $conf_loc -u root:pfsense sftp://192.168.1.1/cf/conf/
#curl -T $reboot_loc -u root:pfsense sftp://192.168.1.1/tmp/

curl -T $conf_loc -uroot:Admin2018 sftp://172.16.0.70/cf/conf/
curl -T $reboot_loc -uroot:Admin2018 sftp://172.16.0.70/tmp/

#scp $conf_loc root@192.168.1.1:/cf/conf/
#scp $reboot_loc root@192.168.1.1:/tmp/

#ssh root@192.168.1.1 '/tmp/reboot.sh'
ssh root@172.16.0.70 '/tmp/reboot.sh'
