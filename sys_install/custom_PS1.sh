#!/bin/bash
#
# custom PS1

cd /etc/profile.d
cat >custom_PS1.sh<<EOF
if [ `id -u` -eq 0 ];then
	PS1="[\[\e[1;31m\]\u\[\e[0m\]@\h \W]\\$ "
elif [ `id -u` -ge 1000 ];then
	PS1="[\[\e[1;32m\]\u\[\e[0m\]@\h \W]\\$ "
fi
EOF
cd - &>/dev/null

. /etc/profile