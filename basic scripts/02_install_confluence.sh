#!/bin/bash

# Define Basic Shell Funcitons

NCL='\033[0m'
CLR='\033[0;31m'
CLG='\033[0;32m'

# Check if script is run as root

if [ "$EUID" -ne 0 ]; then
  echo -e "${CLR}[ USER ] - ERROR: Please run this script as root!${NCL}"
  exit
fi

# Init Script Vars

DOMAIN="wiki.seiler.dev"
CONFLUENCE_BINARY="https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.1.1-x64.bin"

yum install epel-release -y

yum install nginx certbot certbot-nginx wget -y

sed -i 's/permissive/disabled/g' /etc/selinux/config

wget 