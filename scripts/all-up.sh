#! /usr/bin/bash
#

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable

echo 'Destroy VMs'
vagrant destroy -f
echo 'verwijder alle roles'
sudo rm -rf ansible/roles
echo 'Alle roles downloaden'
sudo bash scripts/role-deps.sh

echo 'Alle machines up'
vagrant up quebec1
vagrant up bravo1
vagrant up charlie1
vagrant up oscar1
vagrant up alfa1
vagrant up kilo1
vagrant up papa1
vagrant up delta1
vagrant up lima1
vagrant up november1
vagrant up echo1
vagrant up mike1


echo "KLAAR!!"
