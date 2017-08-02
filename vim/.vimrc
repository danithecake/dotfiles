"
" System
"
" Disable audio bell
set visualbell
" Disable BCE
if $TERM =~ '256color'
  set t_ut=
endif

"
" Plugins
"
let g:vim_plugs = $VIMPLUGS
filetype plugin indent on

"ru! autoload/plug.vim
let s:vim_plug = expand(g:vim_plugs.'/plug.vim')

if filereadable(s:vim_plug)
  exec 'so '.s:vim_plug
  call plug#begin(expand(g:vim_plugs))
    " Snippets
    Plug 'Shougo/neosnippet'
    " Tools
    Plug 'w0rp/ale'
    " UI
    Plug 'rakr/vim-one'
    " Langs
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
  call plug#end()
endif

unlet s:vim_plug

"
" Editor
"
" Spaces instead of tabs by default
set et
" Insert 2 spaces when Tab was pressed
set sts=2
" Insert 2 spaces when was an indent operation
set sw=2
" Enable syntax highlighting
syntax on
" Show tabs and trailing whitespaces
set listchars=tab:\|-,trail:~,extends:>,precedes:<
set list
" Wrap settings
set tw=79
set cc=+1
set wm=2
set lbr
set bri
set sbr=>\ 
" Set default fold method to match indent settings
set foldmethod=indent
set foldlevel=2
set hid

"
" UI
"
set bg=light
" Enable One Vim theme for Vim >8 and Neovim
if (has("termguicolors")) && $TERM =~ '256color'
  set termguicolors
  sil! colo one
endif
" Enable search highlighting by default
set hls
" Search on type
set is
" Show status line by default
set ls=2
" Status line config
let &stl = '[%{toupper(mode())}]%.40F%m%r%=%k%q%h%w%y[%l:%L\|%c][%p:%P]'

"
" Auto commands
"
aug init_aucs
  au!
  au FileType gitconfig setl noet sts& sw&
  " Split tag macro
  au FileType html,htmldjango let @t="vitdiOp==k0"
  " Set file types
  au BufRead,BufNewFile .tern-project setl ft=json
  au BufRead,BufNewFile bash-fc.* setl ft=bash.sh
  au BufRead,BufNewFile *.jsx setl ft=javascript.jsx
aug end

"
" Keymaps
"
" <Leader> key to <Space>
map <Space> \
" Copy/paste to/from system clipboard
no <Leader>xy "+y
no <Leader>xyy "+yy
no <Leader>xp "+p
no <Leader>xP "+P
" Switch relative line mubers
nn <Leader>rn :set rnu! rnu? <CR>
" Write files with sudo access
cno w!! w !sudo tee > /dev/null %
" Edit vimrc
nn <Leader>ec :EditorConf<CR>
" Open help in right vertical panel
no <Leader>h :vert bo help 
" Append closing chars
"let s:close_chars = {"'": "''", "\"": "\"\""}
"for k in keys(s:close_chars)
"  exe "ino ".k." ".s:close_chars[k]."<Left>"
"endfor

"
" Commands
"
com! Scratchpad new | only | setlocal buftype=nofile noswapfile
com! EditorConf exe 'e' expand($MYVIMRC)
