#!/bin/bash
#
# lvs test

vip 192.168.1.1
access=1

while true
do
echo "access $access"
curl $vip
echo
((access++))
sleep 3
done