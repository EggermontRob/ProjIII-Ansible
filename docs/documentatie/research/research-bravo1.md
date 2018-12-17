# DNS-Master Documentatie:
## Opdracht:
*Authoritative-only DNS server voor green.local, gebaseerd op BIND. DNS-requests voor andere domeinen worden NIET beantwoord. De buitenwereld kent deze server als "ns1".*

## Informatie manuele configuratie:
*Meer [info](https://github.com/HoGentTIN/p3ops-green/blob/master/documentatie/dns.md) in detail over BIND Configuratie en lookup zones.*
### Configuratie:
* Zie [Handleiding](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/bravo1/Documentatie/10_Steps_To_DNS.md).

## Informatie automatische configuratie met Ansible:
*Volledige info ansible rol [bertvv-bind](https://github.com/bertvv/ansible-role-bind).*
### Info over ansible-tags:
| Variable | Dafault | Omschrijving |
|:---------|:--------|:-------------|
| `bind_acls`                  | `[]`                             | A list of ACL definitions, which are dicts with fields `name` and `match_list`.                   |
| `bind_allow_query`           | `['localhost']`                  | A list of hosts that are allowed to query this DNS server. Set to ['any'] to allow all hosts                                |
| `bind_allow_recursion`       | `['any']`                        | Similar to bind_allow_query, this option applies to recursive queries.                                                      |
| `bind_check_names`           | `[]`                             | Check host names for compliance with RFC 952 and RFC 1123 and take the defined actioni (e.g. `warn`, `ignore`, `fail`). |
| `bind_dnssec_enable`         | `true`                           | Is DNSSEC enabled                                                                                                           |
| `bind_dnssec_validation`     | `true`                           | Is DNSSEC validation enabled                                                                                                |
| `bind_extra_include_files`   | `[]`                             |                                                                                                                             |
| `bind_forward_only`          | `false`                          | If `true`, BIND is set up as a caching name server                                                                          |
| `bind_forwarders`            | `[]`                             | A list of name servers to forward DNS requests to.                                                                          |
| `bind_listen_ipv4`           | `['127.0.0.1']`                  | A list of the IPv4 address of the network interface(s) to listen on. Set to ['any'] to listen on all interfaces.            |
| `bind_listen_ipv6`           | `['::1']`                        | A list of the IPv6 address of the network interface(s) to listen on                                                         |
| `bind_log`                   | `data/named.run`                 | Path to the log file                                                                                                        |
| `bind_query_log`             | -                                | When defined (e.g. `data/query.log`), this will turn on the query log                                                       |
| `bind_recursion`             | `false`                          | Determines whether requests for which the DNS server is not authoritative should be forwarded.                             |
| `bind_rrset_order`           | `random`                         | Defines order for DNS round robin (either `random` or `cyclic`)                                                             |
| `bind_zone_dir`              | -                                | When defined, sets a custom absolute path to the server directory (for zone files, etc.) instead of the default.            |
| `bind_zone_domains`          | n/a                              | A list of domains to configure, with a seperate dict for each domain, with relevant details                                 |
| `- allow_update`             | `['none']`                       | A list of hosts that are allowed to dynamically update this DNS zone.                                                       |
| `- also_notify`              | -                                | A list of servers that will receive a notification when the master zone file is reloaded.                                   |
| `- delegate`                 | `[]`                             | Zone delegation.                                                                         |
| `- hostmaster_email`         | `hostmaster`                     | The e-mail address of the system administrator for the zone                                                                 |
| `- hosts`                    | `[]`                             | Host definitions.                                                                        |
| `- ipv6_networks`            | `[]`                             | A list of the IPv6 networks that are part of the domain, in CIDR notation (e.g. 2001:db8::/48)                              |
| `- mail_servers`             | `[{name: mail, preference: 10}]` | A list of dicts (with fields `name` and `preference`) specifying the mail servers for this domain.                          |
| `- name_servers`             | `[ansible_hostname]`             | A list of the DNS servers for this domain.                                                                                  |
| `- name`                     | `example.com`                    | The domain name                                                                                                             |
| `- networks`                 | `['10.0.2']`                     | A list of the networks that are part of the domain                                                                          |
| `- other_name_servers`       | `[]`                             | A list of the DNS servers outside of this domain.                                                                           |
| `- services`                 | `[]`                             | A list of services to be advertized by SRV records                                                                          |
| `- text`                     | `[]`                             | A list of dicts with fields `name` and `text`, specifying TXT records. `text` can be a list or string.                      |
| `bind_zone_file_mode`        | 0640                             | The file permissions for the main config file (named.conf)                                                                  |
| `bind_zone_master_server_ip` | -                                | **(Required)** The IP address of the master DNS server.                                                                     |
| `bind_zone_minimum_ttl`      | `1D`                             | Minimum TTL field in the SOA record.                                                                                        |
| `bind_zone_time_to_expire`   | `1W`                             | Time to expire field in the SOA record.                                                                                     |
| `bind_zone_time_to_refresh`  | `1D`                             | Time to refresh field in the SOA record.                                                                                    |
| `bind_zone_time_to_retry`    | `1H`                             | Time to retry field in the SOA record.                                                                                      |
| `bind_zone_ttl`              | `1W`                             | Time to Live field in the SOA record.                                                                                       |

### Verplichte tags:
| Variable                     | Master | Slave | Opmerking |
| :---                         | :---:  | :---: | :-------- |
| `bind_zone_domains`          | V      | V     | |
| `  - name`                   | V      | V     | |
| `  - networks`               | V      | --    | Moet megegeven worden in de slave configuratie voor backward-lookup zones.|
| `  - name_servers`           | V      | --    | |
| `  - hosts`                  | V      | --    | |
| `bind_listen_ipv4`           | V      | V     | |
| `bind_allow_query`           | V      | V     | |
| `bind_acls`                  | --     | --    | Acl's moet gedefinieerd staan als slave configuratie aanwezig is zodanig dat de forward-lookup zones accessible zijn op de master voor de slave. |

### Toevoegen van een nieuwe host aan master:
*Template voor toevoegen van een extra host aan de master server.*
```
    hosts:
      - name: pu001
        ip: 192.0.2.10
        aliases:
          - ns1
      - name: router
        ip:
          - 192.0.2.254
          - 172.16.255.254
        aliases:
          - gw
```

### Voorbeeld van master configuratie:
*Voorbeeld [configuratie](https://github.com/HoGentTIN/p3ops-green/blob/master/ansible/host_vars/bravo1.yml).*

### Voorbeeld van slave configuratie:
*Voorbeeld [configuratie](https://github.com/HoGentTIN/p3ops-green/blob/master/ansible/host_vars/charlie1.yml).*

## Handige file-locaties:
* Locatie van netwerk-interface configuratie:
    - `/etc/sysconfig/network-scripts/`
    - `/etc/sysconfig/network-scripts/ifcfg-eth0`
    - `/etc/sysconfig/network-scripts/ifcfg-eth1`
* Locatie DNS-server informatie voor machine:
    - `/etc/resolv.conf`
* Locatie van de configuratie van BIND:
    - `/etc/named.conf`
* Locatie van forward-lookup zones (Master-DNS):
    - `/var/named/green.local`
* Locatie van backward-lookup zones (Master-DNS):

*Indien er meerdere `Networks` geconfigureerd staan in Ansible, dan is er voor iedere netwerk een `in-addr.arpa` aanwezig.*

    - `/var/named/0.16.172.in-addr.arpa`
* Locatie van forward-lookup zones (Slave-DNS):
    - `/var/named/slaves/green.local`
* Locatie van backward-lookup zones (Slave-DNS):

*Indien er meerdere `Networks` geconfigureerd staan in Ansible, dan is er voor iedere netwerk een `in-addr.arpa` aanwezig.*

    - `/var/named/slaves/0.16.172.in-addr.arpa`

## Handige commando's:
* Voor het opzoeken van een server binnen het domein op alias of naam:

*Kolom met Master- of Slave-DNS geeft aan op welke server het moet uitgevoerd worden.*

| Commando | alias | name | IP | Master-DNS | Slave-DNS | Opmerking |
|:---------|:-----:|:----:|:--:|:----------:|:---------:|:----------|
|`nslookup www.green.local 172.16.0.4`| V | -- | -- | V | -- | |
|`nslookup www.green.local 172.16.0.5`| V | -- | -- | -- | V | |
|`nslookup delta1 172.16.0.4`| -- | V | -- | V | -- | |
|`nslookup delta1 172.16.0.5`| -- | V | -- | -- | V | |
|`nslookup 172.16.0.6 172.16.0.4`| -- | -- | V | V | -- | |
|`nslookup 172.16.0.6 172.16.0.5`| -- | -- | -- | -- | V | |
|`dig www.green.local @172.16.0.4`| V | -- | -- | V | -- | |
|`dig www.green.local @172.16.0.5`| V | -- | -- | -- | V | |
|`dig delta1 @172.16.0.4`| -- | V | -- | V | -- | |
|`dig delta1 @172.16.0.5`| -- | V | -- | -- | V | |
|`dig 172.16.0.6 @172.16.0.4`| -- | -- | V | V | -- | |
|`dig 172.16.0.6 @172.16.0.5`| -- | -- | V | -- | V | |

## Bronnen:
* [Bertvv-Bind](https://github.com/bertvv/ansible-role-bind).
* [Video](https://www.youtube.com/watch?v=0X9em99Vcl0).
