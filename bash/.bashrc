#!/usr/bin/env bash
#
# ~/.bashrc
#

# Source additional Bash configs
confdir=~/.config/bash
if [ -d $confdir ]; then
  while read file; do
    file=${confdir}/${file}
    [ ! -d "$file" ] && [ -f "$file" ] && source $file
  done <${confdir}/.sort
fi
unset confdir

# If not running interactively, don't do anything next
[[ $- != *i* ]] && return

# Refresh local bash history
(history -c; history -r) >/dev/null
