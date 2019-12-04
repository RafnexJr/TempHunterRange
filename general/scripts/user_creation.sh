#!/bin/bash -e

# Define Basic Shell Funcitons

NCL='\033[0m'
CLR='\033[0;31m'
CLG='\033[0;32m'

# Check if script is run as root

if [ "$EUID" -ne 0 ]; then
  echo -e "${CLR}[ USER ] - ERROR: Please run this script as root!${NCL}"
  exit
fi

# Define User Variables

USER_TO_CREATE='stefan.seiler'
GROUP_TO_CREATE='seiler-admins'
PASSWORD="Change!ME"

# Create User and Groups

useradd $USER_TO_CREATE > /dev/null 2>&1

echo -e "${CLG}[ USER ] - Created user: $USER_TO_CREATE${NCL}"

groupadd $GROUP_TO_CREATE > /dev/null 2>&1

echo -e "${CLG}[ USER ] - Created group: $GROUP_TO_CREATE${NCL}"

usermod -aG wheel,$GROUP_TO_CREATE $USER_TO_CREATE > /dev/null 2>&1

echo "$PASSWORD" | passwd $USER_TO_CREATE --stdin > /dev/null 2>&1

echo -e "${CLG}[ USER ] - Set password for user: $USER_TO_CREATE${NCL}"

mkdir /home/$USER_TO_CREATE/.ssh/ > /dev/null 2>&1

cp /root/.ssh/authorized_keys /home/$USER_TO_CREATE/.ssh/authorized_keys > /dev/null 2>&1

chown -R $USER_TO_CREATE:$USER_TO_CREATE /home/$USER_TO_CREATE/.ssh > /dev/null 2>&1

chmod 0600 /home/$USER_TO_CREATE/.ssh/authorized_keys > /dev/null 2>&1

echo "AllowGroups $GROUP_TO_CREATE" >> /etc/sshd > /dev/null 2>&1

echo -e "${CLG}[ USER ] - Restricted SSH access to group: $GROUP_TO_CREATE${NCL}"

systemctl restart sshd