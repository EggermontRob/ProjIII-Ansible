# RELEASE DAY :-)
## CHECKLIST

- [ ] Servers opgestart
- [ ] Servers aangesloten op de correcte switches
- [ ] `git pull`
- [ ] roles wissen en opnieuw downloaden
- [ ] Deployment 1 (D1): ROB (IP: 172.16.0.40 ; DG: 172.16.0.33; SN: 255.255.255.224)
- [ ] Deployment 2 (D2): Ismail (IP: 172.16.0.8 ; DG: 172.16.0.1; SN: 255.255.255.224)
- [ ] D1 : Verbinding met de VM's (ping testen doen naar iedere VM van 172
16.0.3-7)
- [ ] D2 : Verbinding met de VM's (ping testen doen naar iedere VM van 172
16.0.34-40)
- [ ] ALGEMEEN: `cd p3ops-green/ansible`
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l quebec1`
- [ ] D2 : `ansible-playbook site.yml -i inventory.yml -l bravo1`
- [ ] D2 : `ansible-playbook site.yml -i inventory.yml -l charlie1`
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l kilo1`
**NETWERKSERVERS ZIJN RUNNING**
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l papa1`
- [ ] D2 : `ansible-playbook site.yml -i inventory.yml -l alfa1`
- [ ] D2 : `ansible-playbook site.yml -i inventory.yml -l delta1`
**OPLETTEN VOLGORDE november voor mike en echo**
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l november1`
- [ ] D2 : `ansible-playbook site.yml -i inventory.yml -l echo1`
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l mike1`
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l lima1`
- [ ] D1 : `ansible-playbook site.yml -i inventory.yml -l oscar1`


Indien machine bezig is, kan je volgende provisionen in nieuw terminal venster, wel resources van de server in het oog houden. Dat de netwerksnelheid niet te laag is.
Dus best zoals voorgaand telkens 1 server per machine provisionen.
