#!/bin/bash
#
#  /etc/security/limits.conf

grep  "unlimited"  /etc/security/limits.conf
if [ $? -ne 0 ];then
cd  /etc/security/
cat >>limits.conf<<EOF
* soft nproc unlimited
* hard nproc unlimited
* soft nofile 655350
* hard nofile 655350
EOF
cd - &>/dev/null
