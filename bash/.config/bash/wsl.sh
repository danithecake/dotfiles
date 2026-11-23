#!/usr/bin/env bash
#
# Integration with WSL
#

# If not running under WSL, don't do anything next
[[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] || return

#
# Base config
#

# Run SSH Agent Win host bridge
function host-ssh-agent-bridge() {
  [[ -v WSL_USE_HOST_SSH_AGENT ]] || return

  export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

  [[ -S "$SSH_AUTH_SOCK" ]] && return

  # Remove stale socket if it exists but isn't valid
  rm -f "$SSH_AUTH_SOCK"
  # Start the bridge
  ( setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
}

# host-ssh-agent-bridge
unset -f host-ssh-agent-bridge
