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

# Sorted human-readable output from du
function dus {
  du -h -d 1 "${@:-.}" | sort -h
}

# Encrypt file
function encr {
  openssl enc -aes-256-cbc -salt -in "$1"
}

# Decrypt file
function decr {
  openssl enc -aes-256-cbc -d -in "$1"
}

# Replace full path to home directory with "~"
function h2~ {
  cat - | sed "s@${HOME}@~@"
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

# Remove special chars and color code from stdin
function ansi2txt {
  cat - | sed $'s/\e\\[[0-9;:]*[a-zA-Z]//g'
}

# Wrapper for xargs to use it with Bash functions
function fxargs {
  export -f "$1"
  xargs bash -c '$@' _ $@
  unset -f "$1"
}

# DNS flusher
function dns-flush {
  if [[ "$(uname)" =~ "Darwin" ]]; then
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
  fi
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
alias toperf="top -stats pid,command,cpu,threads,idlew,power,time,mem"
alias qgrep="ugrep -Q -R -q --exclude-from=<(cat .gitignore .git/info/exclude)"
alias pcomm="ps -o comm= -p $$ | sed 's/^-//'"
alias ppcomm="ps -o comm= -p $PPID | sed 's/^-//'"

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

# Alias for tinypng with API key from env
function tinypng {
  command tinypng -k $TINYPNG_API_KEY $@
}

# Alias for swift-format to disable colors
function swfrmt {
  swift-format $@ --no-color-diagnostics
}

# Alias for vifm as pipe file picker
function vifmp {
  vifm --choose-files -
}

# Alias for runner to use file list from stdin
function runppr {
  runner --files="$(cat -)" $@
}
