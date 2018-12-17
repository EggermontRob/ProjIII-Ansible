# Netlab002 - fysieke server B.4.037/8

## Systeemeigenschappen

- Dell PowerEdge R410
- CPU: 1x Intel Xeon E5530 @ 2.40GHz
    - totaal 4 cores
    - 4 cores per socket
    - 2 threads per core
- RAM: 8 GiB
- HDD:
    - sda: Dell Virtual Disk, 500 GB (465.25GiB)
    - sdb: Dell Virtual Disk, 300 GB (278.88GiB)
- Network:
    - em1:
        - Broadcom NetXtreme II BVM5716 Gigabit Ethernet
        - 78:2B:CB:18:1B:D5
    - em2:
        - 78:2B:CB:18:1B:D6
    - p1p1:
        - 00:10:18:37:26:8C

### CPU info

```console
[systeam@netlab002 ~]$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    2
Core(s) per socket:    4
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 26
Model name:            Intel(R) Xeon(R) CPU           E5530  @ 2.40GHz
Stepping:              5
CPU MHz:               1596.000
CPU max MHz:           2395.0000
CPU min MHz:           1596.0000
BogoMIPS:              4788.29
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              8192K
NUMA node0 CPU(s):     0-7
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida
```

## Installatie OS

- CentOS 7.5
- Language: English (US)
- Keyboard: us
- Date & Time: Europe/Brussels, NTP on
- Security profile: Common profile for General-Purpose Systems
- Software selection: Minimal install
- Installation destination:
    - Targets: BOTH Dell Virtual Disks
    - LVM partitioning scheme
    - /boot 500 MiB
    - swap 8064 MiB
    - / 735.75 GiB
- Network and host name
    - em1: manual
        - ip 172.22.2.2/255.255.0.0
        - gateway 172.22.255.254
        - DNS 172.22.0.2, 193.190.173.1
    - em2, p1p1: DHCP
    - host name: netlab002.hogent.be
- KDUMP: disabled
- User configuration
    - root wachtwoord: Veushoj0AwOvnak2
    - student, wachtwoord: Projecten3
    - kan inloggen zonder wachtwoord met SSH sleutel in `ansible/files/id_rsa_student_netlab`

## Gebruik KVM

- Installeer op je laptop (onder Linux!) [Virtual Machine Manager](https://virt-manager.org/)
- File > Add Connection:
    - Hypervisor: QEMU/KVM
    - Connect to remote host aanvinken
    - Method: SSH
    - Username: root
    - Hostname: `netlab002` of het IP-adres
- Virtuele machines zitten opgeslagen in `/var/lib/libvirt/images`.

Het is best om voor nieuwe virtuele machines te starten van een vooraf opgezette "basis-image" met een minimale installatie van het besturingssysteem, een gebruiker voor systeembeheertaken die geconfigureerd is voor inloggen met een SSH-sleutel.

## Cockpit monitoring

Op `netlab002` is Cockpit geïnstalleerd. Daarmee kan je de load op het systeem opvolgen, incl. de virtuele machines.

Ga met je webbrowser naar <https://netlab002:9090/> en log in als root.

## Connect command
```bash
ssh -i ansible/files/id_rsa_student_netlab student@netlab002
```
Op `netlab002` is Cockpit geïnstalleerd. Daarmee kan je de load op het systeem opvolgen, incl. de virtuele machines.
