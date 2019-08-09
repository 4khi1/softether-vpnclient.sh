#!/bin/bash

if [[ $# -le 5 ]] ; then
    echo "usage:
    $0	<server> <port> <user> <passwd> <accountname> <hub(optional)>
    "
    exit 0
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

SERVER=$1:$2   # 1194,5555
USERNAME=$3
PASSWORD=$4
ACCOUNTNAME=$5
HUB=${6:-vpn}

/opt/vpnclient/vpncmd /client localhost /cmd niccreate "$ACCOUNTNAME"
/opt/vpnclient/vpncmd /client localhost /cmd accountcreate "$ACCOUNTNAME" /SERVER:"$SERVER" /HUB:"$HUB" /USERNAME:"$USERNAME" /NICNAME:"$ACCOUNTNAME"
/opt/vpnclient/vpncmd /client localhost /cmd accountpasswordset "$ACCOUNTNAME" /PASSWORD:"$PASSWORD" /TYPE:standard
/opt/vpnclient/vpncmd /client localhost /cmd accountstartupset "$ACCOUNTNAME"
/opt/vpnclient/vpncmd /client localhost /cmd accountconnect "$ACCOUNTNAME"
