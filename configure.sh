#!/bin/bash

if [[ $# -lt 5 ]] ; then
    echo "usage:
    $0	<server> <port> <user> <passwd> <accountname> <hub(optional)>
    "
    exit 0
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

SERVER=$1:$2   # 1194,5555,443,53
USERNAME=$3
PASSWORD=$4
ACCOUNTNAME=$5
HUB=${6:-vpn}

sudo /opt/vpnclient/vpncmd /client localhost /cmd niccreate "$ACCOUNTNAME"
sudo /opt/vpnclient/vpncmd /client localhost /cmd accountcreate "$ACCOUNTNAME" /SERVER:"$SERVER" /HUB:"$HUB" /USERNAME:"$USERNAME" /NICNAME:"$ACCOUNTNAME"
sudo /opt/vpnclient/vpncmd /client localhost /cmd accountpasswordset "$ACCOUNTNAME" /PASSWORD:"$PASSWORD" /TYPE:standard
sudo /opt/vpnclient/vpncmd /client localhost /cmd accountdetailset "$ACCOUNTNAME" /MAXTCP:32 /INTERVAL:1 /TTL:0 /HALF:yes /BRIDGE:no /MONITOR:no /NOTRACK:yes /NOQOS:yes
sudo /opt/vpnclient/vpncmd /client localhost /cmd accountstartupset "$ACCOUNTNAME"
sudo /opt/vpnclient/vpncmd /client localhost /cmd accountconnect "$ACCOUNTNAME"
