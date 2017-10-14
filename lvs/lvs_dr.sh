#!/bin/bash
#
# running on lvs director server

# custom vip rip
vip=192.168.1.1
rip1=192.168.1.2
rip2=192.168.1.3

iname=eth0

case "$1" in
	start)
		# set virtual IP address
		ifconfig ${iname}:1 ${vip} broadcast ${vip} netmask 255.255.255.255 up
		route add -host ${vip} dev ${iname}:1

		# configure lvs
		ipvsadm -C
		ipvsadm -A -t ${vip}:80 -s wrr -p 5
		ipvsadm -a -t ${vip}:80 -r ${rip1}:80 -g -w 1
		ipvsadm -a -t ${vip}:80 -r ${rip2}:80 -g -w 1
		ipvsadm-save > /etc/sysconfig/ipvsadm 2>/dev/null

		systemctl start ipvsadm
		echo "start lvs director server"
		;;
	stop)
		ipvsadm -C
		ifconfig ${iname}:1 down
		route del ${vip} &>/dev/null
		echo "lvs director closed."
		;;
	*)
		echo "Usage: $0 start|stop"
		exit 1
		;;
esac
exit 0
