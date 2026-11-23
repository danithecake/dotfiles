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

let s:gui_palette = [
      \ 'Black',
      \ 'Red',
      \ 'Green',
      \ 'Yellow',
      \ 'Blue',
      \ 'Magenta',
      \ 'Cyan',
      \ 'LightGray',
      \ 'Gray',
      \ 'LightRed',
      \ 'LightGreen',
      \ 'LightYellow',
      \ 'LightBlue',
      \ 'LightMagenta',
      \ 'LightCyan',
      \ 'White',
      \ ]

function! s:highlight(group, style)
  for opt in ['cterm', 'ctermbg', 'ctermfg']
    if has_key(a:style, opt)
      let a:style[substitute(opt, 'cterm', 'gui', '')] = a:style[opt]
    endif
  endfor

  for opt in ['guibg', 'guifg']
    if has_key(a:style, opt) && !type(a:style[opt])
      let a:style[opt] = s:gui_palette[a:style[opt]]
    endif
  endfor

  if !has_key(a:style, 'clear') || a:style.clear
    exec 'hi clear '.a:group
  else
    call remove(a:style, 'clear')
  endif

  if !empty(a:style)
    exec 'hi '.a:group.' '.join(map(keys(a:style), 'v:val."=".a:style[v:val]'), ' ')
  endif
endfunction

let g:crystaline = {
  \ 'palette': copy(s:gui_palette),
  \ 'highlight': function('s:highlight')
  \ }

" UI
call s:highlight('SignColumn', {'cterm': 'none'})
call s:highlight('VertSplit', {'cterm': 'none', 'ctermfg': 7})
call s:highlight('Folded', {'cterm': 'none', 'ctermfg': 8})
call s:highlight('FoldColumn', {'cterm': 'none', 'ctermfg': 8})
call s:highlight('TabLine', {})
call s:highlight('TabLineFill', {})
call s:highlight('TabLineSel', {'cterm': 'bold'})
call s:highlight('Pmenu', {'ctermbg': 11})
call s:highlight('PmenuSBar', {'ctermbg': 11})
call s:highlight('PmenuSel', {'cterm': 'reverse'})
call s:highlight('Search', {'ctermbg': 11})
call s:highlight('IncSearch', {'ctermbg': 10})
call s:highlight('ErrorMsg', {'cterm': 'bold', 'ctermfg': 1})
call s:highlight('WarningMsg', {'cterm': 'bold', 'ctermfg': 3})
call s:highlight('Error', {'cterm': 'bold', 'ctermfg': 1})
call s:highlight('Warning', {'cterm': 'bold', 'ctermfg': 3})
" UI-Statusline
call s:highlight('StatusLine', {'ctermfg': 0})
call s:highlight('StatusLineNC', {'ctermfg': 7})

" Editor
call s:highlight('Visual', {'ctermbg': 10, 'ctermfg': 0})
call s:highlight('DiffText', {'cterm': 'bold', 'ctermfg': 4})
call s:highlight('DiffAdd', {'cterm': 'bold', 'ctermfg': 2})
call s:highlight('DiffDelete', {'cterm': 'bold', 'ctermfg': 1})
call s:highlight('DiffChange', {'cterm': 'none'})
call s:highlight('SpellBad', {'cterm': 'bold', 'ctermfg': 1})
call s:highlight('SpellCap', {'cterm': 'bold', 'ctermfg': 3})
call s:highlight('SpellLocal', {'cterm': 'bold', 'ctermfg': 3})
call s:highlight('SpellRare', {'cterm': 'bold', 'ctermfg': 3})

" Syntax
call s:highlight('Statement', {'cterm': 'none'})
call s:highlight('Type', {'cterm': 'none'})
call s:highlight('Function', {'cterm': 'none'})
call s:highlight('Constant', {'cterm': 'none'})
call s:highlight('Identifier', {'cterm': 'none'})
call s:highlight('Delimiter', {'cterm': 'none'})
call s:highlight('Number', {'ctermfg': 2})
call s:highlight('String', {'ctermfg': 4})
call s:highlight('Comment', {'ctermfg': 4})
call s:highlight('PreProc', {'cterm': 'none'})
call s:highlight('Todo', {'cterm': 'bold', 'ctermbg': 3})
