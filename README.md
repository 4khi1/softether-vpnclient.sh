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
## Install
```
git clone https://github.com/akhilin/softether-vpnclient.sh.git /opt/softether-vpnclient.sh
./opt/softether-vpnclient.sh/install.sh <server> <port> <user> <passwd>  # default port is 992
```
## Systemd
```
# to enable on boot
systemctl enable softether-vpnclient
systemctl start softether-vpnclient
```
## Dhc;ient
```
dhclient -v vpn_<accountname>
```
