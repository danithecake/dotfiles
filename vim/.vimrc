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
" Pick file changes made outside
set autoread
" Enable local config auto sourcing
set exrc
" Use makef script as default make command
set makeprg=makef\ $*\ 2>/dev/null
" Use fd as default file finder
if executable('fd')
  let g:findprg = 'fd . -H --type f'
endif
" Add RU-lang by default to spellcheck
silent! set spelllang=en_us,ru_ru
" Get config directory path
let g:config_dir_path = split(&rtp, ',')[0]

"
" Editor
"
set indentexpr=smartindent
" Insert 2 spaces when Tab was pressed
set softtabstop=2
" Insert 2 spaces when was an indent operation
set shiftwidth=2
" Enable syntax highlighting
syntax on
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
" set background=light
if has('termguicolors') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
  set termguicolors
endif
silent! colorscheme crystalline
" Chars that will be used in various UI delimiters
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-
" Use statusline as horizontal border and hide it by default
set statusline=%{repeat('-',winwidth('%'))}
set laststatus=0
" Disable sign column
set signcolumn=no
" Wild menu
set wildignorecase
" Link guicursor styles with corresponding hi groups
set guicursor=n-v-c-sm:block-Cursor
set guicursor+=i-ci-ve:ver25-Cursor
set guicursor+=r-cr-o:hor20
silent! set guicursor+=t:block-blinkon500-blinkoff500-TermCursor
" Mode depended curosr shape
if exists('$TMUX') || &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>[5 q"
  let &t_EI = "\<Esc>[1 q"
else
  let &t_SI = "\<Esc>]50;CursorShape=5\x7"
  let &t_EI = "\<Esc>]50;CursorShape=1\x7"
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
  " Clear problematic tmux syntax
  autocmd FileType tmux syn clear tmuxFormatString
  " Automatically start Neovim's terminal buffer in insert mode
  silent! autocmd TermOpen * startinsert
  " Open quick fix window if it has errors
  autocmd QuickFixCmdPost [^l]*
        \ if len(filter(getqflist(),'v:val.type =~? "e\\|w"')) |
          \ exec 'cwindow '.min([max([getqflist({'size': 1}).size,5]),10]) |
          \ if &ft == 'qf' | wincmd p | endif |
        \ endif
  " Close empty quick fix window
  autocmd QuickFixCmdPost [^l]*
        \ if !getqflist({'size': 1}).size |
          \ cclose |
        \ endif
  " Check if any buffer was changed form outside on CursorHold
  autocmd CursorHold * silent! checktime
  " Set/unset current Tmux pane as a target for tvix
  " autocmd VimEnter * silent! !tmux set-option -w @tvix_vimpane "$(tmux display-message -p :\#I.\#P)"
  " autocmd VimLeave * silent! !tmux set-option -uw @tvix_vimpane
  " autocmd BufLeave * silent! mkview!
  " autocmd BufEnter * silent! loadview
augroup END

"
" Keymaps
"
" <Leader> key to <Space>
map <Space> \
" Slightly faster save ops
nnoremap <leader>w :w<CR>
nnoremap <leader>wa :wa<CR>
" Open help in right vertical panel
nnoremap <Leader>h :vert bo help 
" Edit vimrc
nnoremap <silent> <Leader>ec :EditorConf<CR>
" Toggle search highlight
nnoremap <silent> <Leader>shl :set hlsearch!<CR>
" Toggle spell
nnoremap <silent> <Leader>ssp :setlocal spell!<CR>
" Toggle folds on double click
noremap <expr> <2-LeftMouse> foldclosed('.') == -1 && col('.') > match(getline('.'),'\S') ?
  \ '<2-LeftMouse>' : ':silent! normal za<CR>'
" Copy/paste to/from system clipboard
noremap <Leader>xy "+y
noremap <Leader>xyy "+yy
noremap <Leader>xp "+p
noremap <Leader>xP "+P
" Slightly faster access to some file/buffer related switch commands
nnoremap <Leader>ff :find<Space>
nnoremap <Leader>ob :buffer<Space>
nnoremap <Leader>of :next<Space>
" Switch relative line mubers
nnoremap <Leader>rn :set rnu! rnu? <CR>
" Write files with sudo access
cnoremap w!! w !sudo tee > /dev/null %
" Shortcut to paste recurse wildcard
cnoremap *<C-J> **/
" Shortcut for |
cnoremap <C-J>p <Space>\|<Space>
inoremap <C-J>p <Space>\|<Space>
" Append closing chars
let s:closing_chars = {"'": "''", "\"": "\"\"", "{": "{}"}
for k in keys(s:closing_chars)
  exe "inoremap ".k."<C-J> ".s:closing_chars[k]."<Left>"
endfor

"
" Abbreviations
"
" List only uppercase marks
cabbrev marksu execute 'marks '.join(map(range(65,90), 'nr2char(v:val)'), '')
" List only lowercase marks
cabbrev marksl execute 'marks '.join(map(range(97,122), 'nr2char(v:val)'), '')

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

function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

"
" Plugins
"
let g:plugs_path = has('nvim') ? $NVIMPLUGS : $VIMPLUGS
filetype plugin on
filetype indent off
let s:pathogen = expand(g:plugs_path.'/vim-pathogen/autoload/pathogen.vim')

command! -nargs=1 Plugin silent

if filereadable(s:pathogen)
  exec 'source '.s:pathogen

  command! -nargs=1 Plugin call pathogen#infect(expand(g:plugs_path.'/'.split(<args>, '/')[-1]))

  " Tools
  Plugin 'https://github.com/Shougo/neosnippet.vim'
  Plugin 'https://github.com/machakann/vim-highlightedyank'
  Plugin 'https://github.com/justinmk/vim-dirvish'
  Plugin 'danithecake/tvix'
  " Disable netrw
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
endif
unlet s:pathogen

"
" Extras
"
exec 'source '.expand(g:config_dir_path.'/config.vim')
