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

# Define script variables


yum install bro

mkdir -p /var/lib/bro/{host,site} /var/log/bro/{archive,sorted-logs,stats} /var/spool/bro/tmp

sed -i -e '
    s|LogDir = /usr/logs|LogDir = /var/log/bro|;
    s|SpoolDir = /usr/spool|SpoolDir = /var/spool/bro|;
    ' /etc/bro/broctl.cfg

sed -i -e 's/use_json = F/use_json = T/' /usr/share/bro/base/frameworks/logging/writers/ascii.bro

sudo bro deploy

sudo mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.prezeek
sudo cp ./filebeat.yml /etc/filebeat/filebeat.yml
chown --reference=/etc/filebeat/filebeat.yml.prezeek /etc/filebeat/filebeat.yml
chmod --reference=/etc/filebeat/filebeat.yml.prezeek /etc/filebeat/filebeat.yml
systemctl restart filebeat