set runtimepath+=$HOME/.vim/after
source $HOME/.vimrc

"
" UI
"
set background=light
" Clear highlight for some UI elements
silent! call hiclear#clear()

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
