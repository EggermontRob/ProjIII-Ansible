#!/bin/bash
#Testscript PFsense firewall
#============================

#Voorbereiding
#========================
#Variabelen

Target_Ip=$1

#Installeren packages
echo -e '\e[92mInstalleren packages\e[39m'
sudo yum install nmap
sudo yum install tcpdump

#Maken folder voor resultaten
echo -e '\e[92mMaken folder voor resultaten\e[39m'
mkdir ~/scan_resultaten

#TCP
#========================
#Opzetten packet capture in de achtergrond
echo -e '\e[92mOpzetten packet capture in de achtergrond (TCP)\e[39m'
mkdir ~/scan_resultaten/syn_scan
sudo tcpdump host $Target_Ip -w ~/scan_resultaten/syn_scan/packets &
tcp_PID=$!
#Nmap SYN scan
# -T4 voor snellere tijd, zonder -p- = 1000 meest gebruikte poorten

    echo -e '\e[92mStarten SYN scan (TCP)\e[39m'
    sudo nmap -sS -Pn -T4 -vv --reason -oN ~/scan_resultaten/syn_scan/nmap.syn.results $Target_Ip

#Stoppen van tcpdump packet capture
echo -e '\e[92mStoppen van tcpdump packet capture\e[39m'
kill ${tcp_PID}


#UDP
#========================
echo -e '\e[92mOpzetten packet capture in de achtergrond (UDP)\e[39m'
mkdir ~/scan_resultaten/udp_scan
sudo tcpdump host $Target_Ip -w ~/scan_resultaten/udp_scan/packets &
udp_PID=$!
# -T4 voor snellere tijd, zonder -p- = 1000 meest gebruikte poorten

echo -e '\e[92mStarten volledige UDP scan\e[39m'
sudo nmap -sU -Pn -T4 -vv --reason -oN ~/scan_resultaten/udp_scan/nmap.udp.results $Target_Ip

#Stoppen van tcpdump packet capture
echo -e '\e[92mStoppen van tcpdump packet capture\e[39m'
kill ${udp_PID}

#Bron
#https://www.digitalocean.com/community/tutorials/how-to-test-your-firewall-configuration-with-nmap-and-tcpdump