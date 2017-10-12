#!/bin/bash
#
# update date

yum install -y ntp
systemctl enable ntpd
systemctl start ntpd
hwclock --systohc

echo -e "0 0 * * * systemctl restart ntpd   &&  hwclock --systohc   &>/dev/null" >> /var/spool/cron/root

systemctl restart crond