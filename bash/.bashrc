#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="(\W)\[\e[32m\]>\[\e[0m\] "

#
# Completion
#
lcompl=~/.config/bash-completion
if [ -d "${lcompl}" ]; then
  for f in $lcompl/*; do source $f; done
fi

#
# Aliases
#
alias ls="ls --color=auto"
alias grep="grep --color=auto"

#
# Functions
#

# Prepend specified schema path for wich entry in dconf dump
function dconf-dump {
  if [ ${#1} -gt 1 ]; then
    dconf dump "$1" | sed -r "s|^\[(.*)\]|[${1:1}\1]|;s|//\]$|]|"
  else
    dconf dump "$1"
  fi
}
