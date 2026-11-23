#!/usr/bin/env bash
#
# General utility functions and aliases
#

#
# Base config
#

# Utils
#

# History on/off switcher
function hist-switch {
  if [ -v HISTFILE_BUP ]; then
   export HISTFILE=$HISTFILE_BUP
   unset HISTFILE_BUP
   history -r
   echo "history enabled"
  else
   history -a
   export HISTFILE_BUP=$HISTFILE HISTFILE=/dev/null
   echo "history disabled"
  fi
}

# Prepend specified schema path for wich entry in dconf dump
function dconf-dump {
  if [ ${#1} -gt 1 ]; then
    dconf dump "$1" | sed -r "s|^\[(.*)\]|[${1:1}\1]|;s|//\]$|]|"
  else
    dconf dump "$1"
  fi
}

# Set terminal title
function term-title {
  echo -en "\033]0;${*}\a"
}

# Change directory by using interactive program in $DIRPCKR
function cdi {
  cd $($DIRPCKR) || exit 1
  pwd | h2~
}

# Generate random string from /dev/urandom
# Use first arg to set length of a string (default: 8)
function randstr {
  LC_ALL=C tr -dc "[:alnum:]" </dev/urandom | \
    fold -w "$([ -z "$1" ] && echo 8 || echo "$1" )" | \
    head -n 1
}

# Aliases
#

if [ "$(uname -s)" == "Darwin" ]; then
  alias ls="CLICOLOR=1 ls"
  alias grep="CLICOLOR=1 grep"
else
  alias ls="ls --color=auto"
  alias grep="grep --color=auto"
fi

# Alias for fzf
function fzf {
  command fzf \
    --height=20 \
    --layout=reverse \
    --no-sort \
    --no-color \
    --cycle \
    --keep-right \
    --multi \
    --bind 'ctrl-y:toggle,?:toggle-preview' \
    --bind 'ctrl-a:select-all' \
    $@
}

# Alias for fd to disable colors
function fd {
  command fd --color never $@
}

# Alias for runner to use file list from stdin
function runppr {
  runner --files="$(cat -)" $@
}
