### YML file 
## Site.yml
- Volledig
```
- hosts: november1
  vars:
  become: true
  roles:
    - bertvv.rh-base
    - bertvv.mariadb
    - tvandeveire.ekstack_metricbeat_packetbeat
  pre_tasks:
    - name: Setting hostname
      hostname:
        name: november1.green.local
```
## November.yml
- Volledig
```
rhbase_firewall_allow_services:
  - mysql
dns_nameservers: 
  - "DNS1=172.16.0.40"


mariadb_bind_address: '172.16.0.37' #0.0.0.0
mariadb_port: 3306
mariadb_databases:
  - name: dp_echo1
  - name: wp_mike1
mariadb_users:
  - name: echo1
    password: 'echo1'
    priv: "dp_echo1.*:ALL,GRANT"
    append_privs: 'yes'
    host: "172.16.0.07"
  - name: mike1
    password: 'mike1'
    priv: "wp_mike1.*:ALL,GRANT"
    append_privs: 'yes'
    host: "172.16.0.36"
mariadb_mirror: 'mariadb.mirror.nucleus.be/yum'
mariadb_root_password: 'november1'  
```
- Laat mysql door de firewall
```
rhbase_firewall_allow_services:
  - mysql
```

- DNS wordt ingesteld
```
dns_nameservers: 
  - "DNS1=172.16.0.40"
```

- Zorgt ervoor dat het network inteface ip adres wordt beluisterd 
- 0.0.0.0 zorgt ervoor dat hij naar alles luisterd 
```
mariadb_bind_address: '172.16.0.37' #0.0.0.0
```

- Poort nummer waar op client requests toekomen
```
mariadb_port: 3306
```
- Passwoord dat gebruikt wordt voor met de root user op de database in te loggen
```
mariadb_root_password: 'november1' 
```

- Lijst met databases met ingestelde naam
```
mariadb_databases:
  - name: dp_echo1
  - name: wp_mike1
```

- Lijst met users hun passwoord en hun write read execute rights voor de verwante database
```
mariadb_users:
  - name: echo1
    password: 'echo1'
    priv: "dp_echo1.*:ALL,GRANT"
    append_privs: 'yes'
    host: "172.16.0.07"
    - name: mike1
    password: 'mike1'
    priv: "wp_mike1.*:ALL,GRANT"
    append_privs: 'yes'
    host: "172.16.0.36"
 ```

 - Mirror die gebruikt wordt om de mariadb packages te downloaden
  
 ```
  mariadb_mirror: 'mariadb.mirror.nucleus.be/yum'
 ```
  
