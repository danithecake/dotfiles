#!/usr/bin/env bash
#
# txsm integration
#

# If not running under txsm session, don't do anything next
[[ $TXSM ]] || return

# Source local session bashrc
if [ -f "${SESCONF}/bashrc" ]; then
  source ${SESCONF}/bashrc
fi
