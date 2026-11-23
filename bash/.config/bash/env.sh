#!/usr/bin/env bash
#
# Environment for executables
#

#
# Base config
#

# Source local bash config file
if [[ -f .bashrc.local ]]; then
  cur_path="$(pwd)"
  cur_path="$(readlink -f $cur_path 2>/dev/null)"

  IFS=':' read -ra alw_paths <<< "$LOCAL_BASHRC_PATH"

  for alw_path in "${alw_paths[@]}"; do
    alw_path=$(readlink -f "$alw_path" 2>/dev/null)
    [[ "$cur_path" == "$alw_path"* ]] && source .bashrc.local
  done
fi

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Activates nvm if shell starts in directory with local nvm config
if [[ -f "$NVM_RC" ]]; then
  nvm use --silent $(< $NVM_RC)
fi
