#!/bin/bash
export IOC_EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export VAR_DIR="/opt/nonvolatile/var"
export BASE_VER="3.15.5"
export REQUIRE_VER="3.0.4"
export E3_BIN_DIR="/home/root/epics/base-$BASE_VER/require/$REQUIRE_VER/bin"
export PROCSERV="/usr/local/bin/procServ"
export PROCSERV_PORT=2006
export PROCSERV_IOC_DIR=labs-utgard-evr1
export IOC_ST_CMD=st.labs-utgard-evr1.cmd
source "$E3_BIN_DIR/setE3Env.bash"
$PROCSERV -f -L $VAR_DIR/log/procServ/$PROCSERV_IOC_DIR -i ^C^D -c $VAR_DIR/run/procServ/$PROCSERV_IOC_DIR $PROCSERV_PORT $E3_BIN_DIR/iocsh.bash $IOC_EXEC_DIR/$IOC_ST_CMD &
