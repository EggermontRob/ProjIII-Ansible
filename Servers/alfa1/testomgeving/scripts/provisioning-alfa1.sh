#!/bin/bash

# Author:
#		   Lennert Mertens
#		   Ismail El Kaddouri


set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Colors
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'		 #No Color

echo -e ${CYAN}"Installation script 389-DS"${NC}

# Prequisites
echo -e ${GREEN}"Configure firewall"${NC}
echo "172.16.0.3  alfa1.green.local    alfa1" >> /etc/hosts
echo "alfa1.green.local" > /etc/hostname
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-port=389/tcp
firewall-cmd --permanent --add-port=636/tcp
firewall-cmd --permanent --add-port=9830/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
echo -e ${GREEN}"Completed!"${NC}

# Add EPEL and REMI repositories
echo -e ${GREEN}"Add EPEL and REMI repositories"${NC}
yum install -y epel-release
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
yum repolist
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/remi.repo
echo -e ${GREEN}"Completed!"${NC}

# Performance and Security tuning for LDAP
echo -e ${GREEN}"Performance and security tuning for LDAP"${NC}
echo "net.ipv4.tcp_keepalive_time = 300
net.ipv4.ip_local_port_range = 1024 65000
fs.file-max = 64000" >> /etc/sysctl.conf

echo "*               soft     nofile          8192
*               hard     nofile          8192" >> /etc/security/limits.conf

echo "ulimit -n 8192" >> /etc/profile

echo "session    required     /lib/security/pam_limits.so" >> /etc/pam.d/login
echo -e ${GREEN}"Completed!"${NC}


# Install 389 Directory server
# 1. Create LDAP useraccount
echo -e ${GREEN}"Create LDAP user account"${NC}
sudo useradd -p $(openssl passwd -1 ldapadmin) ldapadmin
echo -e ${GREEN}"Completed!"${NC}

# 2. Install 389-ds-base package using command:
echo -e ${GREEN}"Install LDAP packages"${NC}
yum install -y 389-ds-base openldap-clients
yum install -y idm-console-framework.noarch
yum install -y 389-adminutil.x86_64
yum install -y 389-admin.x86_64
yum install -y 389-admin-console.noarch
yum install -y 389-console.noarch
yum install -y 389-ds-console.noarch
echo -e ${GREEN}"Completed!"${NC}

# 3. Install GNOME using command
echo -e ${GREEN}"Install GNOME for SSH X connection"${NC}
yum -y groups install "GNOME Desktop"
echo -e ${GREEN}"Completed!"${NC}
echo -e ${CYAN}"The server will now restart!"${NC}
reboot
