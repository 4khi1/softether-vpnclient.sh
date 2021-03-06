#!/bin/bash
set -x
sudo git clone https://github.com/SoftEtherVPN/SoftEtherVPN_Stable.git /opt/vpnclient
sudo ./opt/vpnclient/configure
sudo make -C /opt/vpnclient
# sudo make -C /opt/vpnclient install

# sudo cp vpnclient.init /etc/init.d/vpnclient
# sudo chmod +x /etc/init.d/vpnclient

sudo cp vpnclient.service /etc/systemd/system/
sudo systemctl enable vpnclient
sudo systemctl start vpnclient
sudo systemctl status vpnclient
sudo ip a
set +x
