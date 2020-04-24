#!/usr/bin/env bash
#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function prompt-git-bname {
  git bname 2>/dev/null | sed "s/.\{20\}$/.../;s/\(.*\)/\1/"
}

function prompt-git-chcount {
  git lsc 2>/dev/null | wc -l | tr -d ' '
}

function prompt-jobs-count {
  jobs | wc -l | bc | (read j && test "$j" -gt 0 && echo " ${j} ")
}

function prompt {
  PS1=$(printf "\e[1m%s\e[0m\n: " ": \w \e[45;97m$(prompt-jobs-count)\e[0m")
}

export PROMPT_COMMAND=prompt

#
# Completion
#
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion
[ -f ~/.config/bash-completion ] && . ~/.config/bash-completion

#
# Aliases
#
if [ "$(uname -s)" == "Darwin" ]; then
  alias ls="CLICOLOR=1 ls"
  alias grep="CLICOLOR=1 grep"
else
  alias ls="ls --color=auto"
  alias grep="grep --color=auto"
fi

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

function randstr {
  LC_ALL=C tr -dc "[:alnum:]" </dev/urandom | \
    fold -w "$([ -z "$1" ] && echo 8 || echo "$1" )" | \
    head -n 1
}

function nvim {
  if command -v pvi >/dev/null; then
    EDITOR=nvim pvi "$@"
  else
    command nvim "$@"
  fi
}

function vim {
  if command -v pvi >/dev/null; then
    EDITOR=vim pvi "$@"
  else
    command vim "$@"
  fi
}

function term-title {
  echo -en "\033]0;${*}\a"
}
