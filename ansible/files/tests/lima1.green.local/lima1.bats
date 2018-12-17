#! /usr/bin/env bats
#
# Original Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
# Adjusted by: Keanu Nys
#
# Test the Samba fileserver

sut_ip=172.16.0.35
sut_wins_name=GREEN
workgroup=GREEN.LOCAL
admin_user=keanu
admin_password=Test123

samba_share_root=/srv/shares # Root directory of shares
# The name of a directory and file that will be created to test for
# write access (= random string)
test_dir=thisIsATestDirectory
test_file=thisIsATestFile

# {{{Helper functions

teardown() {
  # Remove all test directories and files
  find "${samba_share_root}" -maxdepth 2 -type d -name "${test_dir}" \
    -exec rm -rf {} \;
  find "${samba_share_root}" -maxdepth 2 -type f -name "${test_file}" \
    -exec rm {} \;
  find "/home" -maxdepth 2 -type d -name "${test_dir}" \
    -exec rm -rf {} \;
  find "/home" -maxdepth 2 -type f -name "${test_file}" \
    -exec rm {} \;
  rm -f "${test_file}"
}

# Checks if a user has shell access to the system
# Usage: assert_can_login USER PASSWD
assert_can_login() {
  echo $2 | su -c 'ls ${HOME}' - $1
}

# Checks that a user has NO shell access to the system
# Usage: assert_cannot_login USER
assert_cannot_login() {
  run sudo su -c 'ls' - $1
  [ "0" -ne "${status}" ]
}

# Check that a user has read acces to a share
# Usage: read_access SHARE USER PASSWORD
assert_read_access() {
  local share="${1}"
  local user="${2}"
  local password="${3}"

  run smbclient "//${sut_wins_name}/${share}" \
    --user=${user}%${password} \
    --command='ls'
  [ "${status}" -eq "0" ]
}

# Check that a user has NO read access to a share
# Usage: no_read_access SHARE USER PASSWORD
assert_no_read_access() {
  local share="${1}"
  local user="${2}"
  local password="${3}"

  run smbclient "//${sut_wins_name}/${share}" \
    --user=${user}%${password} \
    --command='ls'
  [ "${status}" -eq "1" ]
}

# Check that a user has write access to a share
# Usage: write_access SHARE USER PASSWORD
assert_write_access() {
  local share="${1}"
  local user="${2}"
  local password="${3}"

  run smbclient "//${sut_wins_name}/${share}" \
    --user=${user}%${password} \
    --command="mkdir ${test_dir};rmdir ${test_dir}"
  # Output should NOT contain any error message. Checking on exit status is
  # not reliable, it can be 0 when the command failed...
  [ -z "$(echo ${output} | grep NT_STATUS_)" ]
}

# Check that a user has NO write access to a share
# Usage: no_write_access SHARE USER PASSWORD
assert_no_write_access() {
  local share="${1}"
  local user="${2}"
  local password="${3}"

  run smbclient "//${sut_wins_name}/${share}" \
    --user=${user}%${password} \
    --command="mkdir ${test_dir};rmdir ${test_dir}"
  # Output should contain an error message (beginning with NT_STATUS, usually
  # NT_STATUS_MEDIA_WRITE_PROTECTED
  [ -n "$(echo ${output} | grep NT_STATUS_)" ]
}

# Check that users from the same group can write to each other’s files
# Usage: assert_group_write_file SHARE USER1 PASSWD1 USER2 PASSWD2
assert_group_write_file() {
  local share="${1}"
  local user1="${2}"
  local passwd1="${3}"
  local user2="${4}"
  local passwd2="${5}"

  echo "Hello world!" > ${test_file}

  smbclient "//${sut_wins_name}/${share}" --user=${user1}%${passwd1} \
    --command="put ${test_file}"
  # In order to overwrite the file, write access is needed. This will fail
  # if user2 doesn’t have write access.
  smbclient "//${sut_wins_name}/${share}" --user=${user2}%${passwd2} \
    --command="put ${test_file}"
}

# Check that users from the same group can write to each other’s directories
# Usage: assert_group_write_dir SHARE USER1 PASSWD1 USER2 PASSWD2
assert_group_write_dir() {
  local share="${1}"
  local user1="${2}"
  local passwd1="${3}"
  local user2="${4}"
  local passwd2="${5}"

  smbclient "//${sut_wins_name}/${share}" --user=${user1}%${passwd1} \
    --command="mkdir ${test_dir}; mkdir ${test_dir}/tst"
  run smbclient "//${sut_wins_name}/${share}" --user=${user2}%${passwd2} \
    --command="rmdir ${test_dir}/tst"
  [ -z $(echo "${output}" | grep NT_STATUS_ACCESS_DENIED) ]
}

#}}}

# Preliminaries

@test 'The ’nmblookup’ command should be installed' {
  which nmblookup
}

@test 'The ’smbclient’ command should be installed' {
  which smbclient
}

@test 'The Samba service should be running' {
  systemctl status smb.service
}

@test 'The Samba service should be enabled at boot' {
  systemctl is-enabled smb.service
}

@test 'The WinBind service should be running' {
  systemctl status nmb.service
}

@test 'The WinBind service should be enabled at boot' {
  systemctl is-enabled nmb.service
}

@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}

@test 'Samba traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*samba\b'
}

#
# 'White box' tests
#

# Users

@test 'Check existence of users' {
  id -u ${admin_user}
}

#@test 'Checks shell access of users' {
#}

#
# Black box, acceptance tests
#

# Samba configuration

@test 'Samba configuration should be syntactically correct' {
  testparm --suppress-prompt /etc/samba/smb.conf
}

@test 'NetBIOS name resolution should work' {
  # Look up the Samba server’s NetBIOS name under the specified workgroup
  # The result should contain the IP followed by NetBIOS name
  nmblookup -U ${sut_ip} --workgroup ${workgroup} ${sut_wins_name} \
    | grep "^${sut_ip} ${sut_wins_name}"
}

# Read / write access to shares
@test 'read access for share ‘itadministra’' {

  #                         Share           User                    Password
  assert_read_access        itadministra     ismail                  Test123
  assert_no_read_access     itadministra     lennert                 Test123
  assert_no_read_access     itadministra     rob                     Test123
  assert_no_read_access     itadministra     robin                   Test123
  assert_no_read_access     itadministra     thomas                  Test123
  assert_read_access        itadministra     itadministratieuser     Test123
  assert_no_read_access     itadministra     verkoopuser             Test123
  assert_no_read_access     itadministra     administratieuser       Test123
  assert_no_read_access     itadministra     ontwikkelinguser        Test123
  assert_no_read_access     itadministra     directieuser            Test123
  assert_no_read_access     itadministra     ${admin_user}           ${admin_password}
}

@test 'write access for share ‘itadministra’' {

  #                              Share        User                  Password
  assert_write_access        itadministra     ismail                  Test123
  assert_no_write_access     itadministra     lennert                 Test123
  assert_no_write_access     itadministra     rob                     Test123
  assert_no_write_access     itadministra     robin                   Test123
  assert_no_write_access     itadministra     thomas                  Test123
  assert_write_access        itadministra     itadministratieuser     Test123
  assert_no_write_access     itadministra     verkoopuser             Test123
  assert_no_write_access     itadministra     administratieuser       Test123
  assert_no_write_access     itadministra     ontwikkelinguser        Test123
  assert_no_write_access     itadministra     directieuser            Test123
  assert_no_write_access     itadministra     ${admin_user}           ${admin_password}
}

@test 'read access for share ‘verkoop’' {

  #                      Share      User                    Password
  assert_no_read_access     verkoop     ismail                  Test123
  assert_read_access     verkoop     lennert                 Test123
  assert_no_read_access     verkoop     rob                     Test123
  assert_no_read_access     verkoop     robin                   Test123
  assert_no_read_access     verkoop     thomas                  Test123
  assert_no_read_access     verkoop     itadministratieuser     Test123
  assert_read_access     verkoop     verkoopuser             Test123
  assert_no_read_access     verkoop     administratieuser       Test123
  assert_no_read_access     verkoop     ontwikkelinguser        Test123
  assert_no_read_access     verkoop     directieuser            Test123
  assert_no_read_access     verkoop     ${admin_user}           ${admin_password}
}

@test 'write access for share ‘verkoop’' {

  #                      Share      User                    Password
  assert_no_write_access     verkoop     ismail                  Test123
  assert_write_access     verkoop     lennert                 Test123
  assert_no_write_access     verkoop     rob                     Test123
  assert_no_write_access     verkoop     robin                   Test123
  assert_no_write_access     verkoop     thomas                  Test123
  assert_no_write_access     verkoop     itadministratieuser     Test123
  assert_write_access     verkoop     verkoopuser             Test123
  assert_no_write_access     verkoop     administratieuser       Test123
  assert_no_write_access     verkoop     ontwikkelinguser        Test123
  assert_no_write_access     verkoop     directieuser            Test123
  assert_no_write_access     verkoop     ${admin_user}           ${admin_password}
}

@test 'read access for share ‘administrat’' {

  #                      Share      User                    Password
  assert_no_read_access     administrat     ismail                  Test123
  assert_no_read_access     administrat     lennert                 Test123
  assert_read_access     administrat     rob                     Test123
  assert_no_read_access     administrat     robin                   Test123
  assert_no_read_access     administrat     thomas                  Test123
  assert_no_read_access     administrat     itadministratieuser     Test123
  assert_no_read_access     administrat     verkoopuser             Test123
  assert_read_access     administrat     administratieuser       Test123
  assert_no_read_access     administrat     ontwikkelinguser        Test123
  assert_no_read_access     administrat     directieuser            Test123
  assert_no_read_access     administrat     ${admin_user}           ${admin_password}
}

@test 'write access for share ‘administrat’' {

  #                      Share      User                    Password
  assert_no_write_access     administrat     ismail                  Test123
  assert_no_write_access     administrat     lennert                 Test123
  assert_write_access     administrat     rob                     Test123
  assert_no_write_access     administrat     robin                   Test123
  assert_no_write_access     administrat     thomas                  Test123
  assert_no_write_access     administrat     itadministratieuser     Test123
  assert_no_write_access     administrat     verkoopuser             Test123
  assert_write_access     administrat     administratieuser       Test123
  assert_no_write_access     administrat     ontwikkelinguser        Test123
  assert_no_write_access     administrat     directieuser            Test123
  assert_no_write_access     administrat     ${admin_user}           ${admin_password}
}

@test 'read access for share ‘ontwikkeling’' {

  #                      Share      User                    Password
  assert_no_read_access     ontwikkeling     ismail                  Test123
  assert_no_read_access     ontwikkeling     lennert                 Test123
  assert_no_read_access     ontwikkeling     rob                     Test123
  assert_read_access     ontwikkeling     robin                   Test123
  assert_no_read_access     ontwikkeling     thomas                  Test123
  assert_no_read_access     ontwikkeling     itadministratieuser     Test123
  assert_no_read_access     ontwikkeling     verkoopuser             Test123
  assert_no_read_access     ontwikkeling     administratieuser       Test123
  assert_read_access     ontwikkeling     ontwikkelinguser        Test123
  assert_no_read_access     ontwikkeling     directieuser            Test123
  assert_no_read_access     ontwikkeling     ${admin_user}           ${admin_password}
}

@test 'write access for share ‘ontwikkeling’' {

  #                      Share      User                    Password
  assert_no_write_access     ontwikkeling     ismail                  Test123
  assert_no_write_access     ontwikkeling     lennert                 Test123
  assert_no_write_access     ontwikkeling     rob                     Test123
  assert_write_access     ontwikkeling     robin                   Test123
  assert_no_write_access     ontwikkeling     thomas                  Test123
  assert_no_write_access     ontwikkeling     itadministratieuser     Test123
  assert_no_write_access     ontwikkeling     verkoopuser             Test123
  assert_no_write_access     ontwikkeling     administratieuser       Test123
  assert_write_access     ontwikkeling     ontwikkelinguser        Test123
  assert_no_write_access     ontwikkeling     directieuser            Test123
  assert_no_write_access     ontwikkeling     ${admin_user}           ${admin_password}
}

@test 'read access for share ‘directie’' {

  #                      Share      User                    Password
  assert_no_read_access     directie     ismail                  Test123
  assert_no_read_access     directie     lennert                 Test123
  assert_no_read_access     directie     rob                     Test123
  assert_no_read_access     directie     robin                   Test123
  assert_read_access     directie     thomas                  Test123
  assert_no_read_access     directie     itadministratieuser     Test123
  assert_no_read_access     directie     verkoopuser             Test123
  assert_no_read_access     directie     administratieuser       Test123
  assert_no_read_access     directie     ontwikkelinguser        Test123
  assert_read_access     directie     directieuser            Test123
  assert_no_read_access     directie     ${admin_user}           ${admin_password}
}

@test 'write access for share ‘directie’' {

  #                      Share      User                    Password
  assert_no_write_access     directie     ismail                  Test123
  assert_no_write_access     directie     lennert                 Test123
  assert_no_write_access     directie     rob                     Test123
  assert_no_write_access     directie     robin                   Test123
  assert_write_access     directie     thomas                  Test123
  assert_no_write_access     directie     itadministratieuser     Test123
  assert_no_write_access     directie     verkoopuser             Test123
  assert_no_write_access     directie     administratieuser       Test123
  assert_no_write_access     directie     ontwikkelinguser        Test123
  assert_write_access     directie     directieuser            Test123
  assert_no_write_access     directie     ${admin_user}           ${admin_password}
}

@test 'users from the same group can write to each other’s files' {

  #                         Share           User1   Pass1   User2               pass2
  assert_group_write_file   itadministra    ismail  Test123 itadministratieuser Test123
  assert_group_write_file   verkoop         lennert Test123 verkoopuser         Test123
  assert_group_write_file   administrat     rob     Test123 administratieuser   Test123
  assert_group_write_file   ontwikkeling    robin   Test123 ontwikkelinguser    Test123
  assert_group_write_file   directie        thomas  Test123 directieuser        Test123
}

@test 'users from the same group can write to each other’s directories' {

  #                         Share           User1   Pass1   User2               pass2
  assert_group_write_dir   itadministra    ismail  Test123 itadministratieuser Test123
  assert_group_write_dir   verkoop         lennert Test123 verkoopuser         Test123
  assert_group_write_dir   administrat     rob     Test123 administratieuser   Test123
  assert_group_write_dir   ontwikkeling    robin   Test123 ontwikkelinguser    Test123
  assert_group_write_dir   directie        thomas  Test123 directieuser        Test123
}
