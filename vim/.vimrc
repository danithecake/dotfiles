"
" System
"
" Disable audio bell
set visualbell
" Disable BCE
if $TERM =~ '256color'
  set t_ut=
endif
" Ignored file patterns for wildcard expanding
set wildignore+=node_modules/*,.git/*
set wildignore+=*.swp,*.swo
set wildignore+=*.exe,*.jpg,*.png,*.gif,*.svg

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
    " Tools
    Plug 'Shougo/neosnippet'
    Plug 'w0rp/ale'
    Plug 'chrisbra/Colorizer'
    Plug 'machakann/vim-highlightedyank'
    " UI
    Plug 'rakr/vim-one'
    " Langs
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'hail2u/vim-css3-syntax'
  call plug#end()
endif

unlet s:vim_plug

"
" Editor
"
" Spaces instead of tabs by default
set expandtab
" Insert 2 spaces when Tab was pressed
set softtabstop=2
" Insert 2 spaces when was an indent operation
set shiftwidth=2
" Enable syntax highlighting
syntax on
" Show tabs and trailing whitespaces
set listchars=tab:\|-,trail:~,extends:>,precedes:<
set list
" Wrap settings
set textwidth=79
set colorcolumn=+1
set wrapmargin=2
set linebreak
set breakindent
set showbreak=>\ 
" Set default fold method to match indent settings
set foldmethod=indent
set foldlevelstart=99
" Allow buffers to be heidden after switching
set hidden
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" Enable inccommand option if exists(for interactive substitution)
if exists('&inccommand')
  set inccommand=nosplit
endif
" Enable omni completion based on syntax file by default
set omnifunc=syntaxcomplete#Complete
" Only insert the longest common text for completion
set completeopt+=menuone,longest,noinsert
set completeopt-=preview

"
" UI
"
set background=light
" Enable One Vim theme for Vim >8 and Neovim
if (has("termguicolors")) && $TERM =~ '256color'
  set termguicolors
  silent! color one
endif
" Show status line by default
set laststatus=2
" Show sign column by default
set signcolumn=yes
" Status line config
let &stl = '[%{toupper(mode())}]%.40F%m%r%=%k%q%h%w%y[%l:%L|%c]'
" Wild menu
set wildmode=full
set wildignorecase

"
" Auto commands
"
augroup init_aucs
  autocmd!
  autocmd FileType gitconfig setlocal noet softtabstop& shiftwidth&
  " Split tag macro
  autocmd FileType html,htmldjango let @t="vitdiOp==k0"
  " Set file types
  autocmd BufRead,BufNewFile .tern-project setlocal ft=json
  autocmd BufRead,BufNewFile bash-fc.* setlocal ft=bash.sh
  autocmd BufRead,BufNewFile *.jsx setlocal ft=javascript.jsx
  autocmd BufRead,BufNewFile *.eslintrc setlocal ft=json
  " Disable sign column for command-line window
  autocmd CmdWinEnter setlocal signcolumn=auto
augroup end

"
" Keymaps
"
" <Leader> key to <Space>
map <Space> \
" Open help in right vertical panel
nnoremap <Leader>h :vert bo help 
" Edit vimrc
nnoremap <Leader>ec :EditorConf<CR>
" Switch off search highlight
nnoremap <Leader>nh :nohlsearch<CR>
" Copy/paste to/from system clipboard
noremap <Leader>xy "+y
noremap <Leader>xyy "+yy
noremap <Leader>xp "+p
noremap <Leader>xP "+P
" Slightly faster access to some file/buffer related switch commands
nnoremap <Leader>of :next<Space>
nnoremap <Leader>ob :buffer<Space>
nnoremap <Leader>ff :find<Space>
" Switch relative line mubers
nnoremap <Leader>rn :set rnu! rnu? <CR>
" Write files with sudo access
cnoremap w!! w !sudo tee > /dev/null %
" Shortcut to paste recurse wildcard
cnoremap *<C-J> **/
" Append closing chars
let s:closing_chars = {"'": "''", "\"": "\"\"", '{': '{}'}
for k in keys(s:closing_chars)
  exe "inoremap ".k."<C-J> ".s:closing_chars[k]."<Left>"
endfor

"
" Commands
"
command! Scratchpad new | only | setlocal buftype=nofile noswapfile
command! EditorConf exe 'e' expand($MYVIMRC)
