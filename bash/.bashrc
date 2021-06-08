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

# export PS1="\[\033[1;35m\]cmd:\[\033[0m\] "
# export PS1="\[\033[34;44m\]:\[\033[35;45m\]:\[\033[31;41m\]:\[\033[0m\] "
# export PS1="\[\033[34m\]|\[\033[35m\]|\[\033[31m\]|\[\033[0m\] "
export PS1="; "

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

function term-title {
  echo -en "\033]0;${*}\a"
}

function tmux-new {
  test -r "$1" && sesfile="$1"
  test ! -r "$sesfile" && sesfile="${XDG_CONFIG_HOME}/tmux/${1}.tmux.conf"
  test ! -r "$sesfile" && sesfile="${HOME}/.config/tmux/${1}.tmux.conf"
  test ! -r "$sesfile" && sesfile="$(cat <&0)"
  test ! -r "$sesfile" && return 1

  tmux -C <$sesfile >/dev/null
  test -z $TMUX && tmux attach || tmux switch-client -n

  unset sesfile
}

function tmux-attach {
  if [ -n "$1" ]; then
    sesname=$1
  else
    sesname=$(ls -t ~/.config/tsessions/ | sed 's/\.conf//' | fzy 2>/dev/null)
  fi

  test -z $sesname && exit 1

  test -z $TMUX && tmux attach -t $sesname || tmux switch-client -t $sesname

  unset sesname
}

function tmux-exp-opt {
  opts=$(tmux show 2>/dev/null) || exit 1

  for opt in "$@"; do
    export $(grep -E $opt <<<$opts | sed "s/@//;s/ /=/")
  done
}

export -f tmux-exp-opt

function fzy-gl {
  git log 2>/dev/null | fzy | awk '{ print $1 }'
}

function fzy-ps {
  ps aux | fzy | awk '{ print $2 }'
}

#
# Bindings
#

# Executables
bind -x '"\C-xgs": git status -sb 2>/dev/null'
bind -x '"\C-xgl": git log 2>/dev/null'
bind -x '"\C-xgd": git diff . 2>/dev/null'
bind -x '"\C-xcp": pwd | sed "s@${HOME}@~@"'

# Snippets
bind '"\C-js": "\$()\C-b"'
bind '"\C-jp": " \| "'
