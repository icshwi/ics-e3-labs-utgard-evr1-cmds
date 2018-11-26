#!/bin/bash
export IOC_EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export VAR_DIR="/opt/nonvolatile/var"
export E3_BIN_DIR="/home/root/vip/epics/base-3.15.5/require/3.0.0/bin"
export PROCSERV="/usr/local/bin/procServ"
export PROCSERV_PORT=2006
export PROCSERV_IOC_DIR=labs-utgard-evr1
export IOC_ST_CMD=st.labs-utgard-evr1.cmd
source "$E3_BIN_DIR/setE3Env.bash"
$E3_BIN_DIR/iocsh.bash $IOC_EXEC_DIR/$IOC_ST_CMD &
