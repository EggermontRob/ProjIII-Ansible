# Problemen DNS 

Tijdens de uitvoering van een van de demo's ontdekten we dat de DNS servers op alle servers verkeerd geconfigureerd werden. Dit werd opgelost met ansible role [lennertmertens.dns](https://galaxy.ansible.com/lennertmertens/dns)

De role zorgt ervoor dat de nameservers kunnen worden meegegeven alsook het search domain en de interface waarop deze instellingen moeten worden geconfigureerd. Om de DNS te laten werken op de omgeving lokaal (op eigen pc) en in het netwerk zelf moeten er enkele zaken worden aangepast.
De aanpassingen worden hieronder voor beide gevallen beschreven.

## Lokaal op eigen pc (voor testing)

De verschillende files zien eruit als volgt:

### site.yml
De post task zorgt ervoor dat PEERDNS op de standaard NAT adapter van VirtualBox wordt uitgeschakeld, dit voorkomt dat VB de verkeerde name server toevoegd aan `/etc/resolv.conf`
```yml
- hosts: all
  vars:
  become: true
  roles:
    - bertvv.rh-base
    - bertvv.hosts
    - lennertmertens.dns
  post_tasks: # Only for testing environment, in demo removed
     - name: Set PEERDNS=no
       lineinfile:
        path: /etc/sysconfig/network-scripts/ifcfg-eth0
        line: PEERDNS=no
     - name: Restart network service
       systemd:
         name: network.service
         state: restarted
```

### group_vars/all.yml
Stel de juiste interface in, nl. `eth1`, de LAN adapter in VirtualBox. Deze instelling zorgt ervoor dat de name servers worden ingesteld op deze adapter.
```yml
# -------------------- DNS Settings --------------------
# Adding the DNS search domain
dns_search: green.local
# Interface name of Host-only adapter
dns_intname: eth1
# Volgende interface is diegene voor op de demo zelf:
#dns_intname: ens192
# ------------------------------------------------------
```

### host_vars/alfa1.yml

alfa1, of eender welke andere server waarop je de DNS servers wilt toevoegen, voeg deze servers toe als volgt
```yml
# Setting DNS servers
dns_nameservers:
  - "DNS1=172.16.0.40" # Stelt quebec1 in als name server
```


## In het klasnetwerk (voor demo)
### site.yml
De post task die ervoor zorgt dat PEERDNS op de standaard NAT adapter van VirtualBox wordt uitgeschakeld, moet in commentaar staan.
```yml
- hosts: all
  vars:
  become: true
  roles:
    - bertvv.rh-base
    - bertvv.hosts
    - lennertmertens.dns
  post_tasks: # Only for testing environment, in demo removed
  #   - name: Set PEERDNS=no
  #     lineinfile:
  #      path: /etc/sysconfig/network-scripts/ifcfg-eth0
  #      line: PEERDNS=no
  #   - name: Restart network service
  #     systemd:
  #       name: network.service
  #       state: restarted
```

### group_vars/all.yml
Stel de juiste interface in, nl. `ens192`, de LAN adapter op de fysieke ESXI server. Deze instelling zorgt ervoor dat de name servers worden ingesteld op deze adapter.
```yml
# -------------------- DNS Settings --------------------
# Adding the DNS search domain
dns_search: green.local
# Interface name of Host-only adapter
#dns_intname: eth1
# Volgende interface is diegene voor op de demo zelf:
dns_intname: ens192
# ------------------------------------------------------
```

### host_vars/alfa1.yml

alfa1, of eender welke andere server waarop je de DNS servers wilt toevoegen, voeg deze servers toe als volgt. Dit is voor demo en testomgeving hetzelfde.
```yml
# Setting DNS servers
dns_nameservers:
  - "DNS1=172.16.0.40" # Stelt quebec1 in als name server
```