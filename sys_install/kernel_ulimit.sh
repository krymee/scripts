#!/bin/bash
#
# kernel ulimit

cat >/etc/profile.d/kernel_ulimit.sh<<EOF
ulimit -SHn 655350
ulimit -SHu unlimited
ulimit -SHd unlimited
ulimit -SHm unlimited
ulimit -SHs unlimited
ulimit -SHt unlimited
ulimit -SHv unlimited
EOF


. /etc/profile


