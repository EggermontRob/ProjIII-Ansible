#!/bin/bash

# Install packages
yum install dhcp tftp tftp-server syslinux vsftpd xinetd -y

# Replace config files for dhcp & tftp
\cp /vagrant/provision/configs/dhcpd.conf /etc/dhcp/dhcpd.conf
\cp /vagrant/provision/configs/tftp /etc/xinetd.d/tftp

# Copy required boot files
cp -v /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot
cp -v /usr/share/syslinux/menu.c32 /var/lib/tftpboot
cp -v /usr/share/syslinux/memdisk /var/lib/tftpboot
cp -v /usr/share/syslinux/mboot.c32 /var/lib/tftpboot
cp -v /usr/share/syslinux/chain.c32 /var/lib/tftpboot

mkdir /var/lib/tftpboot/pxelinux.cfg
cp /vagrant/provision/configs/default /var/lib/tftpboot/pxelinux.cfg/default


# Mount ISOs & copy files to tftp server
for f in /vagrant/isofiles/*; do
    
    INDEX=$(expr $INDEX + 1)
    
    FILENAME=$(basename $f | cut -f 1 -d '.')
    
    mkdir -p /var/lib/tftpboot/$FILENAME
    mkdir /var/ftp/pub/$FILENAME
    
    mount -o loop $f /mnt/
    
    cp -av /mnt/* /var/ftp/pub/$FILENAME
    cp /mnt/images/pxeboot/vmlinuz /var/lib/tftpboot/$FILENAME/
    cp /mnt/images/pxeboot/initrd.img /var/lib/tftpboot/$FILENAME/
    
    umount /mnt/
    
    cat >> /var/lib/tftpboot/pxelinux.cfg/default << EOF
LABEL ${INDEX}
MENU LABEL ^${INDEX}) $FILENAME
KERNEL /$FILENAME/vmlinuz
APPEND initrd=/$FILENAME/initrd.img inst.repo=ftp://10.0.0.2/pub/$FILENAME 

EOF
    
done

# ks=ftp://10.0.0.2/pub/$FILENAME.cfg

# Copy kickstart files
cp /vagrant/provision/configs/kick-centos.cfg /var/ftp/pub/kick-centos.cfg
cp /vagrant/provision/configs/kick-fedora.cfg /var/ftp/pub/kick-fedora.cfg

# Start & enable services
#systemctl restart xinetd
systemctl start xinetd
systemctl enable xinetd
systemctl start dhcpd
systemctl enable dhcpd
systemctl start vsftpd
systemctl enable vsftpd

# Disable SElinux
\cp /vagrant/provision/configs/selinux /etc/sysconfig/selinux
