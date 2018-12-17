# Documentation for installing the 389-ds role
- [389-ds](ansible vmname -i .vagrant/provisioners/ansible/...)

## Prequisites
- Check the available variables in the inventory file of alfa1: `ansible alfa1 -i .vagrant/provisioners/ansible/...`

## Configure firewall
- Add the firewall ports and interfaces needed for 389-ds to [alfa1.yml](../../ansible/host_vars/alfa1.yml)
```yml
rhbase_firewall_allow_ports:
  - 389/tcp
  - 9830/tcp
  - 636/tcp
  - 3269/tcp

rhbase_firewall_interfaces:
  - enp0s3
  - enp0s8
```
## Configure LDAP
 For configuring 389-ds we used an existing role, modified and added some features to it.
 The role is available in [roles/](../../../roles/cscfi.389-ds)
 Based on this role, we're goingto write one ourselves, a better comprehensive one with the packages etc. we used in our manual set-up
 
 
