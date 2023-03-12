#!/usr/bin/env bash
#
# Tmux integration
#

# If not running under tmux, don't do anything next
[[ -z $TMUX ]] && return

#
# Base config
#

# Functions
#

# Alias for display-message command
function txdm {
  tmux display-message -pF "$@"
}

# Print option value
function txpv {
  tmux show-options -qv "$@"
}

# Set an option
function txsv {
  tmux set-option "$@"
}

# Change current dir to a value from @cwd window option
function txcd {
  cd "$(txpv -w @cwd)"
  pwd | h2~
}

# Set current dir to a @cwd window option
function txsd {
  txsv -w @cwd "$(pwd)"
  tmux show-options -q "@cwd"
}

# Flash background of a current pane or pane with provided id.
# By default doesn't flash zoomed panes or single pane inside a window..
function txhp {
  paneid=":."
  hizoomed=""
  hisole=""

  for arg in "$@"; do
    case "$arg" in
      --not-zoomed)
        unset -v hizoomed
        ;;
      --not-sole)
        unset -v hisole
        ;;
      *)
        [[ -n $arg ]] && paneid="$arg"
        ;;
    esac
  done

  [[ ! -v hizoomed ]] && [[ $(txdm "#{window_zoomed_flag}") -eq 1 ]] && return
  [[ ! -v hisole ]] && [[ $(txdm "#{window_panes}") -eq 1 ]] && return

  txsv -p -t"$paneid" window-style bg=pink
  paneid=$(txdm ":#{window_index}.#{pane_index}")
  sleep 0.5
  txsv -p -t"$paneid" -U window-style
}

# Change directory by using interactive program in a $DIRPCKR and set it as @cwd window option
function cdi {
  cd $($DIRPCKR) && txsd || exit 1
  pwd | h2~
}

# If not running interactively, don't do anything next
[[ $- != *i* ]] && return

#
# Interactive config
#

# Save PS1 string to use later for jumping through prompts in copy mode
txsv -g @PS1 "$PS1"

# Save current dir on shell start to a @cwd window option if it wasn't set earlier
[[ -z $(txpv -w @cwd) ]] && txsd >/dev/null

# Use @histfile option as $HISTFILE env variable
histfile="$(txpv @histfile)"
[[ -n $histfile ]] && export HISTFILE=$histfile
unset histfile

# Bindings
#

bind -x '"\C-xtcd": txcd'
