#!/bin/bash
SERVER=$1:$2   # 1194,5555
USERNAME=$3
PASSWORD=$4
ACCOUNTNAME=$5
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

git clone https://github.com/SoftEtherVPN/SoftEtherVPN_Stable.git /opt/softether-vpn
./opt/softether-vpn/configure
make -C /opt/softether-vpn
make -C /opt/softether-vpn install

/opt/softether-vpn/vpnclient start
/opt/softether-vpn/vpncmd /client localhost /cmd niccreate "$ACCOUNTNAME"
/opt/softether-vpn/vpncmd /client localhost /cmd accountcreate $ACCOUNTNAME /SERVER:"$SERVER" /HUB:vpn /USERNAME:"$USERNAME" /NICNAME:softether
/opt/softether-vpn/vpncmd /client localhost /cmd accountpasswordset $ACCOUNTNAME /PASSWORD:"$PASSWORD" /TYPE:standard
/opt/softether-vpn/vpncmd /client localhost /cmd accountstartupset $ACCOUNTNAME
/opt/softether-vpn/vpnclient stop

# startup script
cat << EOF > /etc/init.d/softether-vpnclient
#!/bin/sh
### BEGIN INIT INFO
# Provides: softether-vpnclient
# Required-Start: $network
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start VPN Client at boot time
# description: Start VPN Client at boot time.
# processname: softether-vpnclient
### END INIT INFO
case "\$1" in
    start)
        echo "Starting VPN Client"
        /opt/softether-vpn/vpnclient start
        ;;
    stop)
        echo "Stopping VPN Client"
        /opt/softether-vpn/vpnclient stop
        ;;
    *)
        echo "Usage: /etc/init.d/softether-vpnclient {start|stop}"
        exit 1
        ;;
esac
exit 0
EOF

chmod +x /etc/init.d/softether-vpnclient
/etc/init.d/softether-vpnclient start
