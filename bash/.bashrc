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
