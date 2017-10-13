#!/bin/bash
#
# kernel ulimit
cd /etc/profile.d
cat >kernel_ulimit.sh<<EOF
ulimit -SHn 655350
ulimit -SHu unlimited
ulimit -SHd unlimited
ulimit -SHm unlimited
ulimit -SHs unlimited
ulimit -SHt unlimited
ulimit -SHv unlimited
EOF
cd - &>/dev/null

. /etc/profile


