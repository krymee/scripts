#!/bin/bash
##
# Check the intranet connection
# author Phiix
# Date 2018-02-10
##

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
export LANG=en_US.UTF-8

trap "exit 1" INT

ip_array=(1 10 119 165 173 180 183 193 200 201)
for i in ${!ip_array[@]}
do
    ip=192.168.0.${ip_array[$i]}
    ping -c 3 -W 3 ${ip} >/dev/null 2>&1
    if [ $? -ne 0 ];then
        echo "`date +%F\ %T` [Error]: Host ${ip} cannot connect, please check the host status."
    fi
done
