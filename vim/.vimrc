"
" System
"
" Disable audio and visual bell
set visualbell t_vb=
" Disable BCE
if $TERM =~ '256color'
  set t_ut=
endif
" Ignored file patterns for wildcard expanding
set wildignore+=node_modules/*,.git/*
set wildignore+=*.swp,*.swo
set wildignore+=*.exe,*.jpg,*.png,*.gif,*.svg
set title
set mouse=a
set path-=/usr/include
" Make copy of the file and overwrite the original one
set backupcopy=yes
" Small time out on key codes
set ttimeoutlen=10

"
" Plugins
"
let g:plugs_path = $VIMPLUGS
filetype plugin indent on
let s:pathogen = expand(g:plugs_path.'/vim-pathogen/autoload/pathogen.vim')

command! Plugin silent

if filereadable(s:pathogen)
  exec 'source '.s:pathogen

  command! -nargs=1 Plugin call pathogen#infect(expand(g:plugs_path.'/'.split(<args>, '/')[-1]))

  " Tools
  Plugin 'https://github.com/Shougo/neosnippet.vim'
  Plugin 'https://github.com/machakann/vim-highlightedyank'
endif
unlet s:pathogen

"
" Editor
"
" Insert 2 spaces when Tab was pressed
set softtabstop=2
" Insert 2 spaces when was an indent operation
set shiftwidth=2
" Disable syntax highlighting
syntax off
" Show tabs and trailing whitespaces
set listchars=tab:\|-,trail:.,extends:>,precedes:<
set list
" Wrap settings
set textwidth=79
set wrapmargin=2
set linebreak
set breakindent
set showbreak=>
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
" Enable omni completion based on syntax file by default
set omnifunc=syntaxcomplete#Complete
" Only insert the longest common text for completion
set completeopt+=menuone,longest,noinsert
set completeopt-=preview
" Decrease completion priority for directory matches
set suffixes+=,
" Enable inccommand option if exists(for interactive substitution)
silent! set inccommand=nosplit

"
" UI
"
set background=light
if has('termguicolors') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
  set termguicolors
endif
silent! colorscheme crystalline
" Chars that will be used in various UI delimiters
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-
" Show status line by default
set laststatus=2
" Show sign column by default
set signcolumn=yes
" Status line config
set statusline=[%{toupper(mode())}]
set statusline+=%m
set statusline+=%r
set statusline+=%{winnr()!=winnr('#')?'[•]':''}
set statusline+=%{empty(@%)?'':'['}%<%f%{empty(@%)?'':']'}
set statusline+=%=%k%y[%l:%L\|%c]
" Wild menu
set wildignorecase
" Mode depended curosr shape
if exists('$TMUX') || &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>[5 q"
  let &t_EI = "\<Esc>[0 q"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"
" Auto commands
"
augroup init
  autocmd!
  autocmd FileType gitconfig setlocal noet softtabstop& shiftwidth&
  autocmd FileType vim setlocal expandtab
  " Disable sign column for command-line window
  autocmd CmdWinEnter setlocal signcolumn=auto
  " Enable spellcheck
  autocmd FileType gitcommit setlocal spell
  " Automatically start Neovim's terminal buffer in insert mode
  silent! autocmd TermOpen * startinsert
augroup END

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
" Switch relative line mubers
nnoremap <Leader>rn :set rnu! rnu? <CR>
" Write files with sudo access
cnoremap w!! w !sudo tee > /dev/null %
" Shortcut to paste recurse wildcard
cnoremap *<C-J> **/
" Slightly faster access to :grep commands
cnoremap gr<C-J> sil! grep! -r 
cnoremap lgr<C-J> sil! lgrep! -r 
nmap <Leader>gw :gr<C-J><C-R><C-W>
nmap <Leader>lgw :lgr<C-J><C-R><C-W>
" Append closing chars
let s:closing_chars = {"'": "''", "\"": "\"\"", '{': '{}'}
for k in keys(s:closing_chars)
  exe "inoremap ".k."<C-J> ".s:closing_chars[k]."<Left>"
endfor

"
" Commands
"
command! Scratchpad enew | setlocal buftype=nofile noswapfile
command! EditorConf exec 'drop '.expand('$HOME/.vimrc')
command! BufsToQFList call setqflist(BufsToQuickFix(), 'r', 'Buffers') | copen
command! -nargs=? BufsToLocList call setloclist(empty(<q-args>) ? 0 : <q-args>, BufsToQuickFix(), 'r', 'Buffers') | lopen

"
" Functions
"
function! BufsToQuickFix()
  return map(
        \   filter(range(1, bufnr('$')), 'buflisted(v:val)'),
        \   {val -> {
        \     'lnum': v:val,
        \     'text': empty(bufname(v:val)) ? '[No Name]' : bufname(v:val)
        \   }}
        \ )
endfunction
