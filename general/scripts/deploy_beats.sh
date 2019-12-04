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

# Define script variables

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cp ../files/elastic.repo /etc/yum.repos.d/
chmod --reference=/etc/yum.repos.d/epel.repo /etc/yum.repos.d/elastic.repo