#!/usr/bin/env bash
#
# Completion config
#

# If not running interactively, don't do anything next
[[ $- != *i* ]] && return

#
# Interactive config
#

hbrew_bashcomp=/opt/homebrew/etc/bash_completion.d
[ -d $hbrew_bashcomp ] && for f in $hbrew_bashcomp/*; do source $f; done
[ -f /usr/local/etc/profile.d/bash_completion.sh ] && . /usr/local/etc/profile.d/bash_completion.sh
[ -f ~/.config/bash-completion ] && . ~/.config/bash-completion
command -v runner > /dev/null && eval $(runner --completion=bash)
