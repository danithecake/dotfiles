#!/usr/bin/env bash
#
# Environment for executables
#

#
# Base config
#

# Source nvm if starts in directory with its config
if [[ -f "$NVM_RC" ]] && [[ -s "$NVM_SRC" ]]; then
  source "$NVM_SRC" && nvm use --silent $(< $NVM_RC)
fi
