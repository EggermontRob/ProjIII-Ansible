#!/bin/sh
#-------------------------------------------------------------------------------
#Script voor pfsense reboot.
#
#Auteur: Kenzie Coddens
#-------------------------------------------------------------------------------

#Verwijderen bestand dat initial GUI wizard lanceert
rm /cf/conf/trigger_initial_wizard

#Reboot commando voor pfsense
reboot
