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


yum install epel-release wget git-y
yum install cmake3 -y
ln -s /usr/bin/cmake3 /usr/bin/cmake

yum install make flex bison libpcap-devel openssl-devel python-devel swig zlib-devel -y

yum install libmaxminddb-devel -y

git clone --recursive https://github.com/zeek/zeek

cd zeek
./configure
make
make install

