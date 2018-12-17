# Firewall Zulu1 Documentatie:
## Opdracht:
* **zulu1** bevindt zich tussen VLANs 60 en 70.
* OS: De meest recente stabiele versie van PFSense.
* Deze Firewall heeft NAT uitgeschakeld! NAT is actief op de router Router0.
* Configureer deze firewall zodanig dat enkel die poorten openstaan die echt nodig zijn binnen uw netwerk
* Configureer deze firewall zodanig dat je vanuit elk subnet van je netwerk/LAN (zowel de VLANs als de router subnets) kan communiceren met het internet.

## Informatie OS PfSense:
*PfSense is een open-source project. PfSense is bijna even krachtig als een betalende alles omvattende business solution. Het kan draaien op om het even welke host OS (Linux, Windows, freeBSD...). Het kan draaien op weinig resources. Het is een OS opzich gebaseerd op een FreeBSD versie. PfSense biedt zowel firewall en routing functionaliteit aan. PfSense kan geconfigureerd worden door een WebGui.*

## Automatiseren Van Configuratie PfSense:
*Helaas is het onmogelijk om de volledige installatie van PfSense te automatiseren. Gelukkig is er wel een zeer simpele manier om gemakkelijk de configuratie automatisch te laten verlopen. Er zijn nog andere manieren dan deze. Zie [DOC](https://www.netgate.com/docs/pfsense/backup/automatically-restore-during-install.html) van PfSense.*

### Configuration from USB during Install
*pfSense has, as part of the installation routine, a step that checks for an existing configuration on a USB drive and, if one is found, copies it to the target drive.*

* First, make sure to have a ``config.xml`` backup from the old firewall
* On a DOS/FAT formatted USB drive, make a directory called ``conf``
* Copy a backup configuration file to the ``conf`` directory
* Rename the backup to ``config.xml``

  Example:
  ```
  If the USB drive is E:, the full path would be E:\conf\config.xml
  ```

* Unmount/eject the USB drive, remove it, then plug it into the firewall
* Boot the install media (Memstick, disc, etc)
* Install to the target disk
* Reboot the firewall
* Remove the USB drive only **AFTER** the firewall has begun to reboot

  Warning: 
  ```
  If the USB drive is removed too early, it may still be mounted and the system **will panic**!
  ```

* Remove the install media as well at this point

The firewall will boot off the target disk with the restored configuration.

### Configuratie Restoren via WebGui
* Install PfSense zoals normaal
* Stel De Lan interfaces correct in via de terminal.
* Connecteer met de WebGui
* Ga naar Diagnostic
* Backup & Restore
* Klik op Restore Config.xml

### Configuratie restoren door config te overriden
*Voor dat u dit uitvoert moet u zorgen dat u reeds een backup config.xml heeft gedownload en hernoemd naar config.xml.*

* Installeer pfSense zoals normaal.
* Stel de LAN-Adapter correct in.
* Enable SSHD.
* Open een teminal op een host systeem.
* Doe een `scp` vanop de host naar de server.
```
kenzi@Laptop-KC MINGW64 /d/kenzie/Documents/Projecten - Workshops 3/Git/p3ops-green (master)
$ scp Servers/zulu1/config_file/config.xml root@172.16.0.70:/cf/conf/config.xml
Password for root@Zulu1.green.local:
config.xml                                                  100%   14KB   1.8MB/s   00:00
```
* SSH in pfSense en doe een reboot.
```
kenzi@Laptop-KC MINGW64 /d/kenzie/Documents/Linux/Git/repo (solution)
$ ssh root@172.16.0.70
Password for root@Zulu1.green.local:
VirtualBox Virtual Machine - Netgate Device ID: 1a6169e2e8e00ee7a254

*** Welcome to pfSense 2.4.4-RELEASE (amd64) on Zulu1 ***

 WAN (wan)       -> em0        -> v4: 172.16.0.73/30
 LAN (lan)       -> em1        -> v4: 172.16.0.70/30

 0) Logout (SSH only)                  9) pfTop
 1) Assign Interfaces                 10) Filter Logs
 2) Set interface(s) IP address       11) Restart webConfigurator
 3) Reset webConfigurator password    12) PHP shell + pfSense tools
 4) Reset to factory defaults         13) Update from console
 5) Reboot system                     14) Disable Secure Shell (sshd)
 6) Halt system                       15) Restore recent configuration
 7) Ping host                         16) Restart PHP-FPM
 8) Shell

Enter an option: 5


pfSense will reboot. This may take a few minutes, depending on your hardware.
Do you want to proceed?

    Y/y: Reboot normally
    R/r: Reroot (Stop processes, remount disks, re-run startup sequence)
    S: Reboot into Single User Mode (requires console access!)
    F: Reboot and run a filesystem check

Enter an option: y

pfSense is rebooting now.
Connection to 172.16.0.70 closed by remote host.
Connection to 172.16.0.70 closed.

```

*Nu gaat de pfSense server herstarten en de nieuwe/back-up config inladen. Dit is een omslachtigere manier maar zorgt er wel voor dat de auto configuratie kan gescript worden. AANDACHT: Als u dit uitvoert dan krijgt u toch nog de initiele wizard te zien als u inlogt op de WEBGui. Hier hoeft u niks meer te veranderen. Gewoon op next blijven klikken tenzij anders gevraagd.*

## Info over shell van PfSense:
*Zoals eerder vermeld is PfSense gebaseerd op [FreeBSD](https://www.freebsd.org/nl/). Dit wil niet zeggen dat linux commando's niet werken. De commando's werken maar enkel de basis commando's. Je kunt verschillende pakketten die meegeleverd zijn door PfSense in `/etc/` aanspreken en doen runnen in de shell. Dit alles kan gedaan worden in de terminal van PfSense of vanop afstand via SSH. Je kunt ook de Firewall configureren maar dit is te strengste afgeraden vermits dit niet de bedoeling is en bepaalde controles tijdens boot up kunnen doen falen.*
