#!/bin/bash
# init system conf

if [ ! -f /etc/profile.d/colorps1.sh ];then
	\cp ./colorps1.sh /etc/profile.d/  >/dev/mull 2>&1
	. /etc/profile.d/colorps1.sh
fi

