# Werkwijze

1. OPTIONEEL: routers booten
2. CONTROLEREN OFDAT R4 EN R2 DCE POORTEN ZIJN
3. Kabels insteken
4. Sdm controleren, moet lanbase-routing zijn voor s2-3 ( **sh sdm prefer** )
5. Configuratie kopiëren

# Testplan

1. Op l3 switches: controleren of alle vlans in up-up state zijn ( **sh ip int br** )
2. Op routers: controleren of alle interfaces in up-up state zijn ( **sh ip int br** )
3. Testhost instellen in vlan20, manueel IP instellen:

- Address: 172.16.1.20
- Mask: 255.255.255.192
- DG: 172.16.1.1

4. Vanuit testhost pingen naar:

- DG: 172.16.1.1 (probleem? -\&gt; IP instellingen controleren, kabels en poorten controleren)
- 172.16.0.33 (DG vlan30, testen connectivity vlan20-30)
- 172.16.0.65 (vlan 40, trunking testen)
- 172.16.0.1(DG vlan50, connectivity vlan20-50)
- 172.16.0.70(algemene DG van linux testen)
- 192.0.2.1(R2 testen)
- DHCP adres van NAT-poort
- telnet 157.193.43.50 80 (internet testen)

5. 2e host instellen in vlan30, manueel IP instellen:

- Address: 172.16.1.55
- Mask: 255.255.255.224
- DG: 172.16.0.33

6. 3e host instellen in vlan50, manueel IP instellen:

- Address: 172.16.0.15
- Mask: 255.255.255.224
- DG: 172.16.0.1

7. Pingen van elke host naar elke andere host om inter-vlan routing te testen. Bij falen eerst eens een andere IP proberen alvorens te troubleshooten.

## GRE Tunnels testen

Show ip int br (kijken of hij actief is)

Show interface tunnel 1 (link protocols moet actief staan)

Show ip route (tunnel moet erin staan)

Show ip eigrp neighbor