#!/bin/bash
#
# update date

yum install -y ntp
systemctl enable ntpd
systemctl start ntpd
hwclock --systohc