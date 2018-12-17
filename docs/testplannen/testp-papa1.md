# Testplan Papa1

Benodigdheden voor het testen:

* Vagrant 2.* of hoger
* Ansible 2.5.* of hoger
* Virtualbox 5.2.* of hoger
* Virtualbox Extension Pack
* **DHCPServer kilo1**
    - **VOLG EERST DE STAPPEN UIT HET TESTPLAN VAN DEZE SERVER**


## Testen PXEBoot server (Papa1)


Start de PXEBoot server met commando.  
**Note**: de VM mag nog **NIET** geprovisioned worden

```
vagrant up papa1 
```

Verbind met de server via ssh met commando
```
vagrant ssh papa1
```

Controleer of de services up en running zijn met commando

```
sudo systemctl status xinetd
sudo systemctl status vsftpd
```

## Aanmaken Client

Maak een client aan in virtualbox:

* Kies voor new machine
* Type: Fedora (64-bit)
* Kies voor 3GB RAM geheugen
* Maak een dynamische virtuele harde schijf aan van 40GB

Enable network booting:

* Ga naar de instellingen van de virtuele machine
* Onder "system" tab, duid network aan en plaats deze zo dat Hard Disk als eerste staat en network als tweede optie onder "Boot Order"
  
Configureer de netwerk interfaces:

* Voeg een Host-only adapter toe en zet deze in hetzelfde netwerk als Papa1
* Voeg een NAT adapter toe


**Note:** Er moeten 2 clients aangemaakt worden, 1 voor Fedora en 1 voor CentOS


## Testen Client CentOS

* Start de client VM en kies voor server
* Herstart de machine na de installatie en start het systeem vanaf de hard drive 
  (dit gebeurd normaal gezien automatisch wanneer de boot order goed ingesteld staat)
* Log in met gebruikersnaam `vagrant` en paswoord `vagrant`
* Bekijk de CentOS versie met commando `cat /etc/centos-release`

### Andere mogelijke testen CentOS

* Ping de andere machines binnen het netwerk

## Testen Client Fedora

* Start de client VM en kies voor werkstation
* Herstart de machine na de installatie en start het systeem vanaf de hard drive 
  (dit gebeurd normaal gezien automatisch wanneer de boot order goed ingesteld staat)
* Log in met gebruikersnaam `vagrant` en paswoord `vagrant`
* Bekijk de Fedora versie in terminal met commando `cat /etc/fedora-release`
* Kijk in het Gnome applicatie menu of de webbrowser, Office, Mailclient en PDF-viewer aanwezig zijn


### Andere mogelijke testen Fedora

* Ping de andere machines binnen het netwerk 
* Verstuur een e-mail naar een andere client binnen het netwerk
* Test toegankelijkheid tot netwerkshares
