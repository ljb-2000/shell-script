#!/bin/bash

HOST=$HOSTNAME
IPADDR=$(ifconfig eth0 | grep 'inet addr:' | awk -F":" '{print $2}' | awk -F" " '{print $1}')
DNSSERVER=$(cat /etc/resolv.conf | tail -1 | awk -F" " '{print $2}')
DNSFILE='./zone'
KEYFILE='/usr/local/python/csvt_python/bind/Kmydns.+157+12843.key'
TTL=$3
TYPE=$2
ACTION=$1

getKey(){
    wget http://$DNSSERVER/keys/Kmydns.+157+12843.key.tar.gz > /dev/null 2>&1 
    tar -zxvf Kmydns.+157+12843.key.tar.gz > /dev/null 2>&1 
    if [[ $? == 0 ]];then
        return 0
    fi 
}

parserZone(){
    getKey
    if [ ! -e $DNSFILE ];then
        touch $DNSFILE
    fi
    `: > $DNSFILE`
    echo server $DNSSERVER >> $DNSFILE
    echo zone david.com >> $DNSFILE
    if [[ $ACTION == 'add' ]];then
        echo update add $HOST.david.com. $TTL $TYPE $IPADDR >> $DNSFILE
    elif [[ $ACTION == 'delete' ]];then
        echo update delete $HOST.david.com. $TYPE >> $DNSFILE
    fi
    echo show >> $DNSFILE
    echo send >> $DNSFILE
}

updateDns(){
    parserZone
    echo $KEYFILE
    nsupdate -k '/Kmydns.+157+12843.key'  -v $DNSFILE 
}

updateDns
