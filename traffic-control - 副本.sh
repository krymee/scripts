#!/bin/bash
#author weskiller 2017-11-21
#
debug=''
Interface=eth0
BandWidth=100Mbit
UserLimit=8Mbit
LeaderLimit=16Mbit
ServerLimit=48Mbit
WifiLimit=24Mbit
Limit=128kbit

config=/etc/ethers

#clear
echo "`date +%F\ %T` traffic-control cleared"
$debug tc qdisc del dev $Interface root
#init
echo "`date +%F\ %T` traffic-control init"
$debug tc qdisc add dev $Interface root handle 1:0 cbq bandwidth $BandWidth avpkt 1000

while read line;do
	if echo $line |grep -Pq "^#";then
		if echo $line|grep -Piq "^#(server|wifi|user|leader|default)$";then
			case ${line,,} in
				*server)
					limit=$ServerLimit
					;;
				*user)
					limit=$UserLimit
					;;
				*wifi)	
					limit=$WifiLimit
					;;
				*leader)
					limit=$LeaderLimit
					;;
				*)
					limit=$Limit
					;;
			esac
		else
			continue;
		fi
	else
		ip=${line% *}
		rule=${ip##*.}
		$debug tc class add dev eth0 parent 1:0 classid 1:$rule cbq bandwidth $limit rate $limit allot 1514 weight 20Kbit prio 5 maxburst 20 avpkt 1000 bounded
		$debug tc qdisc add dev eth0 parent 1:$rule sfq quantum 1514b perturb 15
		$debug tc filter add dev eth0 parent 1:0 protocol ip prio 100 u32 match ip dst $ip flowid 1:$rule
	fi
done < /etc/ethers

