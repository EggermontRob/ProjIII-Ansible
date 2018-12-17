# Opdracht papa1

Een PXEBoot-server die toelaat om hosts over het netwerk te installeren. Voorzie via een menu
twee mogelijkheden: server of werkstation.  

Een server wordt geïnstalleerd met de laatste versie van CentOS, en is via Kickstarter automatisch
voorgeconfigureerd om in het netwerk opgenomen te worden (bv. administrator-gebruiker,
package-installatie, configuratie updates). Het systeem kan dan verder geconfigureerd worden
via configuration management en stuurt ook meteen informatie over de werking door naar het
monitoringsysteem.  

Een werkstation wordt geïnstalleerd met Fedora Workstation, dat voorgeconfigureerd werd via
Kickstarter met typische software (webbrowser, Office, Mailclient, PDF-viewer, enz.). Na installatie
kan het werkstation meteen gebruikt worden op het netwerk (bv. gebruikerslogin, email, toegang
netwerkshares, aanvaarden certificaten webservers, enz.).
