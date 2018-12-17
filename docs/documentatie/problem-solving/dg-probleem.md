# Problemen DG in demo-omgeving

Tijdens een van de demo's ontdekten we dat er geen internet was op de verschillende servers zonder NAT adapter. Na troubleshooting bleek het probleem te liggen bij de default gateway die incorrect werd ingesteld.

Om deze problemen op te lossen werden volgende taken toegevoegd:

### site.yml

Deze `post_tasks` werden aan alle servers toegevoegd, de default gateway werd ingesteld op:
- Voor VLAN 50: `172.16.0.1`
- Voor VLAN 30: `172.16.0.33`

```yml
- hosts: alfa1
  vars:
  become: true
  roles:
    - lennertmertens.389ds
    - tvandeveire.ekstack_metricbeat_packetbeat
  pre_tasks:
    - name: Setting hostname
      hostname:
        name: alfa1.green.local
  post_tasks:
    - name: Remove the NAT default gateway on ens224
      shell: nmcli con modify ens224 ipv4.never-default true # Zorgt ervoor dat de NAT default gateway wordt verwijderd
    - name: Configure default gateway on ens192
      shell: nmcli con modify "System ens192" ipv4.never-default false
    - name: Add default gateway
      shell: nmcli con modify "System ens192" ipv4.gateway 172.16.0.1 # Stelt de DG van de LAN adapter in op het juiste IP adres
    - name: Restart network service
      systemd:
        name: network.service
        state: restarted

# Doe dit voor ALLE servers
```

**Opmerking: Deze tasks zijn specifiek voor de demo-omgeving. Wil je dit in de test-omgeving laten werken dan dien je de adapters aan te passen**