#!/bin/bash
#
# lock the system import files

case "$1" in
	lock)
		echo "locking start..."
		chattr +ia /etc/passwd
		chattr +ia /etc/shadow
		chattr +ia /etc/group
		chattr +ia /etc/gshadow
		chattr +ia /etc/services 
		lsattr  /etc/passwd  /etc/shadow  /etc/group  /etc/gshadow  /etc/services
		;;
	unlock)
		echo "unlocking..."
		chattr -ia /etc/passwd
		chattr -ia /etc/shadow
		chattr -ia /etc/group
		chattr -ia /etc/gshadow
		chattr -ia /etc/services
		lsattr  /etc/passwd  /etc/shadow  /etc/group  /etc/gshadow  /etc/services
		;;
	*)
		echo "Usage: $0 lock|unlock"
		;;
esac