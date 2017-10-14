#!/bin/bash
#
# running on realservers

vip=192.168.1.1

case "$1" in
	start)
		echo "prepare for real server"
		echo 1 >/proc/sys/net/ipv4/conf/lo/arp_ignore
		echo 2 >/proc/sys/net/ipv4/conf/lo/arp_announce
		echo 1 >/proc/sys/net/ipv4/conf/all/arp_ignore
		echo 2 >/proc/sys/net/ipv4/conf/all/arp_announce
		ifconfig lo:0 ${vip} broadcast ${vip} netmask 255.255.255.255 up
		route add -host ${vip} dev lo:0
		echo "realserver is OK"
		;;
	stop)
		ifconfig lo:0 down
		route del ${vip} &>/dev/null
		echo 0 >/proc/sys/net/ipv4/conf/lo/arp_ignore
		echo 0 >/proc/sys/net/ipv4/conf/lo/arp_announce
		echo 0 >/proc/sys/net/ipv4/conf/all/arp_ignore
		echo 0 >/proc/sys/net/ipv4/conf/all/arp_announce
		echo "realserver stopped"
		;;
	*)
		echo "Usage: $0 start|stop"
		exit 1
		;;
esac
exit 0