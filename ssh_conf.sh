#!/bin/bash
#
# ssh config

cp   -f  /etc/ssh/ssh_config  /etc/ssh/ssh_config.bak  &>/dev/null
cp   -f  /etc/ssh/sshd_config  /etc/ssh/sshd_config.bak  &>/dev/null
sed  -i '/^#PermitRootLogin yes/a PermitRootLogin no' /etc/ssh/sshd_config
sed  -i '/^#Port 22/a Port 222' /etc/ssh/sshd_config
sed  -i '/Port 22/a Port 222' /etc/ssh/ssh_config
