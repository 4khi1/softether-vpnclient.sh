#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

git clone https://github.com/SoftEtherVPN/SoftEtherVPN_Stable.git /opt/vpnclient
./opt/vpnclient/configure
make -C /opt/vpnclient
#make -C /opt/vpnclient install

cp vpnclient.init /etc/init.d/vpnclient
chmod +x /etc/init.d/vpnclient
systemctl enable vpnclient
systemctl start vpnclient
systemctl status vpnclient
ip a
