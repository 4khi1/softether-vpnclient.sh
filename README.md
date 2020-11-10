# Softether VPN Client Setup and Configuration
## Install Dependencies
Ubuntu/Debian
```
apt install gcc make libtool
```
Redhat/CentOS
```
yum install gcc make libtool
```
## Install & Configure vpnclient
```bash
# clone this repo
sudo git clone https://github.com/akhilin/softether-vpnclient.sh.git /opt/softether-vpnclient.sh
# compile and install vpnclient with systemd service file
sudo /opt/softether-vpnclient.sh/install.sh
# configure any number of vpn client accounts
sudo /opt/softether-vpnclient.sh/configure.sh <server> <port> <user> <passwd> <accountname> <hub>
```
## Systemd Unit
```
systemctl enable/start/status/stop vpnclient
```
## dhclient
```
dhclient -rv vpn_<accountname>
```
