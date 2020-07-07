# Softether VPN Client
## Install dependencies:
Ubuntu/Debian
```
apt install gcc make libtool
```
CentOS
```
yum install gcc make libtool
```
## Install & Configure
```
sudo git clone https://github.com/akhilin/softether-vpnclient.sh.git /opt/softether-vpnclient.sh
sudo /opt/softether-vpnclient.sh/configure.sh <server> <port> <user> <passwd> <accountname> <hub(optional)> # default port is 992 and hub:vpn
```
## Systemd Unit
```
# to enable on boot
systemctl enable vpnclient
systemctl start vpnclient
```
## Dhclient
```
dhclient -v vpn_<accountname>
```
