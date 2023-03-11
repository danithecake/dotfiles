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
bind -x '"\C-xgl": git log 2>/dev/null'
bind -x '"\C-xgd": git diff . 2>/dev/null'
bind -x '"\C-xcp": pwd | sed "s@${HOME}@~@"'

# Snippets
#

bind -r "\C-j"
bind '"\C-js": "\$()\C-b"'
bind '"\C-jp": " \| "'
