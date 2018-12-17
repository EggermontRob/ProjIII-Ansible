echo "uri ldap://alfa1.green.local" >> /etc/sudo-ldap.conf
echo "ldap_version 3" >> /etc/sudo-ldap.conf
echo "pam_password md5" >> /etc/sudo-ldap.conf
echo "host 172.16.0.3" >> /etc/sudo-ldap.conf
echo "base dc=green,dc=local" >> /etc/sudo-ldap.conf
echo "binddn uid=admin,ou=Administrators,ou=TopologyManagement,o=NetscapeRoot" >> /etc/sudo-ldap.conf
echo "bindpw ldapadmin" >> /etc/sudo-ldap.conf
echo "port 389" >>/etc/sudo-ldap.conf
echo "Done setting Ldap Config"

echo "Copying '/vagrant/Servers/lima1/smbldap.conf' to '/etc/smbldap-tools/smbldap.conf'."
cp /vagrant/Servers/lima1/smbldap.conf /etc/smbldap-tools/smbldap.conf
echo "Copying '/vagrant/Servers/lima1/smbldap_bind.conf' to '/etc/smbldap-tools/smbldap_bind.conf'."
cp /vagrant/Servers/lima1/smbldap_bind.conf /etc/smbldap-tools/smbldap_bind.conf

echo "Setting ldap admin password."
smbpasswd -w ldapadmin

echo "Setting '/etc/pam.d/password-auth'"
cp /vagrant/Servers/lima1/password-auth /etc/pam.d/password-auth
cp /vagrant/Servers/lima1/password-auth /etc/pam.d/password-auth-ac

echo "Editing '/etc/openldap/ldap.conf'"
echo "URI ldap://ds.stratus.local/" >> /etc/openldap/ldap.conf
echo "BASE dc=stratus,dc=local" >> /etc/openldap/ldap.conf

echo "Restarting the smb and nmb service."
systemctl restart smb
systemctl restart nmb

echo "changing sequrity = user to domain"
sed -i 's/security = user/security = domain/' /etc/samba/smb.conf

echo "Restarting the smb and nmb service."
systemctl restart smb
systemctl restart nmb

echo "Executing smbldap-populate."
smbldap-populate

echo "End of script."
