" Customizations for tmux
" Maintainer: Daniel Golovachev <danithecake@gmail.com>

if !get(g:, 'loaded_tmux', 0)
 finish
endif

if !$TMUX
  finish
endif

call system('tmux set-option -w @cwd "'.getcwd().'"')
