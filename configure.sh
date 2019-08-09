#!/bin/bash
SERVER=$1:$2   # 1194,5555
USERNAME=$3
PASSWORD=$4
ACCOUNTNAME=$5
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

/opt/vpnclient/vpnclient start
/opt/vpnclient/vpncmd /client localhost /cmd niccreate "$ACCOUNTNAME"
/opt/vpnclient/vpncmd /client localhost /cmd accountcreate $ACCOUNTNAME /SERVER:"$SERVER" /HUB:vpn /USERNAME:"$USERNAME" /NICNAME:softether
/opt/vpnclient/vpncmd /client localhost /cmd accountpasswordset $ACCOUNTNAME /PASSWORD:"$PASSWORD" /TYPE:standard
/opt/vpnclient/vpncmd /client localhost /cmd accountstartupset $ACCOUNTNAME
/opt/vpnclient/vpnclient stop
