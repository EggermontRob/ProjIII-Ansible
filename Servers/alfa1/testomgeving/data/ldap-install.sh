# !/bin/bash
# Configuring LDAP server
echo -e ${GREEN}"Configuring LDAP server"${NC}
setup-ds-admin.pl << EOF

yes
2

ldapadmin
ldapadmin


ldapadmin
ldapadmin





ldapadmin
ldapadmin


EOF

echo -e ${GREEN}"Completed!"${NC}

# Starting/Stopping 389-ds services
echo -e ${GREEN}"Starting and enabling 389-ds services"${NC}
systemctl enable dirsrv.target
systemctl enable dirsrv-admin
systemctl start dirsrv.target
systemctl start dirsrv-admin
echo -e ${GREEN}"Completed!"${NC}
echo -e ${CYAN}"Server installation completed!"${NC}
