#!/usr/bin/env bash
#
# Bindings
#

# If not running interactively, don't do anything next
[[ $- != *i* ]] && return

#
# Interactive config
#

# Executables
#

bind -x '"\C-xgs": git status -sb 2>/dev/null'
bind -x '"\C-xgl": git log -n 10 2>/dev/null'
bind -x '"\C-xgd": git diff . 2>/dev/null'
bind -x '"\C-xgdc": git diff --cached 2>/dev/null'
bind -x '"\C-xgcb": git branch | fzf --no-color | awk "{print $NF}" | xargs git checkout 2>/dev/null'
bind -x '"\C-xcp": pwd | sed "s@${HOME}@~@"'
bind -x '"\C-xfg": fg'
bind '"\C-xfm": " $FILEMAN\C-m"'
bind -x '"\C-xcd": cdi'
bind -x '"\C-xtr": " echo \C-v\C-o\C-m"'
bind -x '"\C-xhu": history -a; export HISTFILE_BUP=$HISTFILE HISTFILE=/dev/null; echo "hist disabled"'
bind -x '"\C-xhr": ([ -v HISTFILE_BUP ] || exit); export HISTFILE=$HISTFILE_BUP; unset HISTFILE_BUP; history -r; echo "hist restored"'
bind -x '"\C-xhs": hist-switch'

# Snippets
#

bind -r "\C-j"
bind '"\C-js": "\$()\C-b"'
bind '"\C-jx": " \| xargs "'
bind '"\C-jp": " \| "'
bind '"\C-jgpb": "\$(git branch --format=\"%(refname:short)\" \| fzf)\e\C-e"'
