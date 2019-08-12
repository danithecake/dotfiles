" Vim color file
" Maintainer: Danil Golovachev <danithecake@gmail.com>
" Last Change:  2019 Jul 25

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "crystalline"

hi clear TabLine
hi clear TabLineFill
hi clear TabLineSel
hi clear StatusLine
hi clear StatusLineNC
hi clear VertSplit
hi clear SignColumn
hi clear Folded
hi clear FoldColumn
hi clear DiffChange
hi clear DiffText
hi clear DiffAdd
hi clear DiffDelete
hi clear IncSearch

hi TabLineSel cterm=bold gui=bold
hi StatusLineNC cterm=none ctermbg=none ctermfg=8 gui=none
hi Visual ctermbg=10 guibg=#5ff967
hi DiffText ctermbg=14 guibg=#5ffdff
hi DiffAdd ctermbg=10 guibg=#5ff967
hi DiffDelete ctermbg=9 guibg=#ff6d67
hi IncSearch ctermbg=11 guibg=#5ff967
hi ErrorMsg ctermbg=1 ctermfg=15 guibg=#c91b00 guifg=#ebebeb
