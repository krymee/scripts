#!/bin/bash
#date 2017-10-20
trap 'exit 0' INT   
bind="vpn1"     

declare -i disconnect=0
while :;do	
	gw=192.168.10.101
	ping -W 2 -c 5 $gw >/dev/null 2>&1   
	if [ $? -eq 0 ];then     
		if [ $disconnect -eq 1 ];then
			echo "`date +%F\ %T` : reconnect $bind"
			disconnect=0
		else
			echo "`date +%F\ %T` : connected $bind"
		fi
	else		
		poff $bind >/dev/null 2>&1
		echo "`date +%F\ %T` : disconnect $bind" |tee -a /var/log/vpn.log
		disconnect=1;
		pon $bind >/dev/null 2>&1
		peer=""
		start=`date +%s`
		end=$((start+3))
		while [ "x${peer}" == "x" ] && [ `date +%s` -le $end ] ;do
			peer=`ip address show|grep -Po "(?<=peer )192.168.10.\d+(?=/)" 2>/dev/null`
		done
		if [ "x$peer" != "x" ];then
			ip route add 192.168.10.0/24 via $peer
		fi
	fi
	sleep 10
done
