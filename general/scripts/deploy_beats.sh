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
rm /etc/audit/rules.d/audit.rules
cp ../files/auditd-attack.rules /etc/audit/rules.d/attack.rules
chown root:root /etc/audit/rules.d/attack.rules
chmod --reference=/etc/audit/audit.rules /etc/audit/rules.d/attack.rules
yum install -y filebeat
mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.back
cp ../configs/filebeat.yml /etc/filebeat/filebeat.yml
chown --reference=/etc/filebeat/filebeat.yml.back /etc/filebeat/filebeat.yml
chmod --reference=/etc/filebeat/filebeat.yml.back /etc/filebeat/filebeat.yml
yum install -y metricbeat
mv /etc/metricbeat/metricbeat.yml /etc/metricbeat/metricbeat.yml.back
cp ../configs/metricbeat.yml /etc/metricbeat/metricbeat.yml
chown --reference=/etc/metricbeat/metricbeat.yml.back /etc/metricbeat/metricbeat.yml
chmod --reference=/etc/metricbeat/metricbeat.yml.back /etc/metricbeat/metricbeat.yml
yum install -y packetbeat
mv /etc/packetbeat/packetbeat.yml /etc/packetbeat/packetbeat.yml.back
cp ../configs/packetbeat.yml /etc/packetbeat/packetbeat.yml
chown --reference=/etc/packetbeat/packetbeat.yml.back /etc/packetbeat/packetbeat.yml
chmod --reference=/etc/packetbeat/packetbeat.yml.back /etc/packetbeat/packetbeat.yml
