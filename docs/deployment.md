# Production deployment documentatie
Deployment zal verlopen via ansible. Hiervoor moet ansible geïnstalleerd worden op de provision-machine.

Er wordt gebruik gemaakt van een inventory file met daarin alle nodige informatie zoals de ip-addressen van de remote host, de gebruikersnaam en wachtwoord, ... klik [hier](/ansible/inventory.yml).

## Stap 1: ESXI
1. Surf naar https://172.22.2.10 en https://172.22.2.11
2. Ga naar het tabblad 'Virtual Machines' 
3. Check de checkbox van de eerste server
4. klik op 'Actions', schuif naar 'Snapshots' en klik op 'Restore Snapshot'. Bevestig met 'Restore'
5. Ga zo verder tot alle servers terug zijn gebracht naar hun laatste snapshot.
6. Start alle servers op

## Stap 2: Provision Quebec1
1. Open een terminal in de map `ansible` 
2. Voer het commando `ansible -i inventory.yml projecten3  -l quebec1 -m setup`. 
    1. Indien de error "Using a SSH password instead of a key.." voorkomt, voer dan het commando `export ANSIBLE_HOST_KEY_CHECKING=False` uit. 
3. Start de provisioning via het commando `ansible-playbook site.yml -i inventory.yml -l quebec1`

## Stap 3: Ga zo verder volgens de volgorde beschreven in het draaiboek

## Troubleshooting
Indien provisioning niet onmiddelijk start, `ssh root@IP_VM` , daar voor je het commando `dhclient` uit. 


## Bronnen
https://www.packer.io  
https://www.packer.io/docs/provisioners/ansible-local.html  
https://www.packer.io/docs/provisioners/ansible.html  
https://docs.ansible.com/ansible/2.5/network/getting_started/first_playbook.html  
https://ansible-tips-and-tricks.readthedocs.io/en/latest/ansible/commands/  
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-centos-7  
https://serverfault.com/questions/800565/ansible-error-missing-target-hosts  
https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html  
https://gist.github.com/arunoda/7790979  
https://stackoverflow.com/questions/42835626/to-use-the-ssh-connection-type-with-passwords-you-must-install-the-sshpass-pr  
