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

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# Completion
#
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion
[ -f ~/.config/bash-completion ] && . ~/.config/bash-completion

