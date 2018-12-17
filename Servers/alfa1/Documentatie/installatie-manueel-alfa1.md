# Documentatie manuele installatie alfa1

_De installatie wordt uitgevoerd in samenwerking met Ismail El Kaddouri, samen schrijven we ook deze documentatie._

**NOTE:** We verkiezen om een 389 AD te installeren


## Server specificaties testopstelling
- Testopstelling wordt opgezet met Vagrant
- Operating System: `bento\centos-7.5`
- Installeer [GUI] (https://www.rootusers.com/how-to-install-gnome-gui-in-centos-7-linux/) voor CentOS als dit gewenst is
- FQDN: `alfa1.green.local`
- IP-Adrress: `172.16.0.3/27`

## Installeer 389-DS Server
### Prequisites

#### 1. Set server FQDN in /etc/hosts file
```
vi /etc/hosts
[...]
172.16.0.3   alfa1.green.local    alfa1
```

#### 2. Firewall configuration
```
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-port=389/tcp
firewall-cmd --permanent --add-port=636/tcp
firewall-cmd --permanent --add-port=9830/tcp
firewall-cmd --reload
```

#### 3. Add EPEL and REMI Repository
Download:
```
yum install -y epel-release
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
```
Edit file `remi.repo`
```
vi /etc/yum.repos.d/remi.repo
```

Find the line enabled=0 and change it to 1 to enable REMI repository.
```
[...]
enabled=1
[...]
```
Save and close the file
Now list out all the installed repsitories: `yum repolist`

#### 4. Performance and Security tuning for LDAP server
Edit file `/etc/sysctl.conf`
```
vi /etc/sysctl.conf
[...] # Add at the bottom
net.ipv4.tcp_keepalive_time = 300
net.ipv4.ip_local_port_range = 1024 65000
fs.file-max = 64000
```

Edit file `/etc/security/limits.conf`
```
vi /etc/security/limits.conf
[...]
*               soft     nofile          8192   
*               hard     nofile          8192
```
Edit file `/etc/profile`
```
vi /etc/profile
[...] # Add at the bottom
ulimit -n 8192
```

Edit file `/etc/pam.d/login`
```
vi /etc/pam.d/login
[...] # Add the line at the end
session    required     /lib/security/pam_limits.so
```

Restart the server

### Install 389 Directory Server

1. Create a LDAP user account:
```
useradd ldapadmin
passwd ldapadmin
```

2. Install 389-ds-base package using command:
```
yum install 389-ds-base openldap-clients
```
Install the remaining required packages:
```
yum install -y idm-console-framework.noarch
yum install -y 389-adminuitil.x86_64
yum install -y 389-admin.x86_64
yum install -y 389-admin-console.noarch
yum install -y 389-console.noarch
yum install -y 389-ds-console.noarch
```

### Configure LDAP Server

Configure 389 directory server: `setup-ds-admin.pl`

```
sudo setup-ds-admin.pl
```
Input for the file in script
```


2

ldapadmin
ldapadmin


ldapadmin
ldapadmin





ldapadmin
ldapadmin



```
The LDAP server should be installed!

#### Starting/Stopping 389-ds services
Make LDAP server services to start automatically on every reboot:
```
systemctl enable dirsrv.target
systemctl enable dirsrv-admin
systemctl start dirsrv.target
systemctl start dirsrv-admin
```

#### Test LDAP Server

Issue the following command: `ldapsearch -x -b "dc=unixmen,dc=local"`

#### Add Users and OU's manually

Done with config.sh
