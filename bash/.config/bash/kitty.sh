#!/usr/bin/env bash
#
# Integration with Kitty terminal
#

# If not running under Kitty, don't do anything next
[[ -v $KITTY_PID ]] && return

#
# Base config
#

kittyscript="$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
if [[ -n "$KITTY_INSTALLATION_DIR" ]] && [[ -e "$kittyscript" ]]; then
  source "$kittyscript"
fi
unset -v kittyscript
