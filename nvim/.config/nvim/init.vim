set runtimepath+=$HOME/.vim/after
source $HOME/.vimrc

"
" Editor
"
" Enable inccommand option if exists(for interactive substitution)
if exists('&inccommand')
  set inccommand=nosplit
endif

"
" Auto commands
"
augroup init
  autocmd!
  autocmd TermOpen * startinsert
augroup END
