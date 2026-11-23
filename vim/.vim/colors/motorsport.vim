" Vim color file
" Maintainer: Danil Golovachev <danithecake@gmail.com>
" Last Change:  2019 Jul 25

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "motorsport"

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

" UI
call s:highlight('SignColumn', {'cterm': 'none'})
call s:highlight('VertSplit', {'cterm': 'none', 'ctermfg': 0})
call s:highlight('Folded', {'cterm': 'none', 'ctermfg': 0})
call s:highlight('FoldColumn', {'cterm': 'none', 'ctermfg': 0})
call s:highlight('TabLine', {})
call s:highlight('TabLineFill', {})
call s:highlight('TabLineSel', {'cterm': 'bold'})
call s:highlight('Pmenu', {'ctermbg': 8})
call s:highlight('PmenuSBar', {'ctermbg': 8})
call s:highlight('PmenuSel', {'cterm': 'bold', 'ctermbg': 8})
call s:highlight('IncSearch', {'ctermbg': 4, 'ctermfg': 15})
call s:highlight('Search', {'cterm': 'bold', 'ctermfg': 4})
call s:highlight('ErrorMsg', {'ctermbg': 1, 'ctermfg': 15})
call s:highlight('WarningMsg', {'ctermbg': 3, 'ctermfg': 15})
call s:highlight('Error', {'ctermfg': 1})
call s:highlight('Warning', {'ctermfg': 3})
" UI-Statusline
call s:highlight('StatusLine', {'ctermfg': 8})
call s:highlight('StatusLineNC', {'ctermfg': 0})

" Editor
call s:highlight('Visual', {'ctermbg': 8})
call s:highlight('DiffText', {'cterm': 'bold', 'ctermfg': 1})
call s:highlight('DiffAdd', {'ctermfg': 4})
call s:highlight('DiffDelete', {'ctermfg': 1})
call s:highlight('DiffChange', {'cterm': 'none'})
call s:highlight('SpellBad', {'ctermfg': 1})
call s:highlight('SpellCap', {'ctermfg': 1})
call s:highlight('SpellLocal', {'ctermfg': 1})
call s:highlight('SpellRare', {'ctermfg': 1})

" Syntax
call s:highlight('Statement', {'cterm': 'bold'})
call s:highlight('Type', {'cterm': 'bold'})
call s:highlight('Function', {'cterm': 'bold'})
call s:highlight('Constant', {'cterm': 'bold'})
call s:highlight('Identifier', {'cterm': 'none'})
call s:highlight('Delimiter', {'cterm': 'none'})
call s:highlight('Number', {'ctermfg': 2})
call s:highlight('String', {'ctermfg': 4})
call s:highlight('Comment', {'cterm': 'italic'})
call s:highlight('PreProc', {'cterm': 'italic'})
call s:highlight('Todo', {'cterm': 'bold', 'ctermfg': 1})

" augroup motorsport
"   autocmd!
"   autocmd VimEnter * hi clear
" augroup end
