#!/usr/bin/env bash
#
# Environment for executables
#

#
# Base config
#

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Activates nvm if shell starts in directory with local nvm config
if [[ -f "$NVM_RC" ]]; then
  nvm use --silent $(< $NVM_RC)
fi
