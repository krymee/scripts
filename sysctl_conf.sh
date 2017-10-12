#!/bin/bash
#
# kernel tuning 内核调优
grep  "net.ipv4" /etc/sysctl.conf  &>/dev/null
if [  $? -ne 0 ];then
cd /etc/
cat >sysctl.conf<<EOF
net.ipv4.ip_forward = 1
net.core.somaxconn = 65535
net.core.netdev_max_backlog = 262144
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.route.max_size = 5242880
net.ipv4.route.gc_timeout = 20
net.ipv4.ip_local_port_range = 1025 65535
net.ipv4.tcp_retries2 = 5
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_syn_retries = 3
net.ipv4.tcp_synack_retries = 3
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_keepalive_time = 120
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_max_tw_buckets = 200000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_wmem = 8192 131072 16777216
net.ipv4.tcp_rmem = 32768 131072 16777216
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_tcp_timeout_established = 180
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 1
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
net.unix.max_dgram_qlen = 655360
kernel.msgmnb = 655360
kernel.msgmax = 655360
kernel.msgmni = 20480
EOF
cd - &>/dev/null

sysctl -p

grep "error" /var/log/secure