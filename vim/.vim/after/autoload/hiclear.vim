function! hiclear#clear()
  hi clear TabLine
  hi clear TabLineFill
  hi clear TabLineSel
  hi clear StatusLine
  hi clear StatusLineNC
  hi clear VertSplit
  hi clear SignColumn
  hi clear Folded
  hi clear FoldColumn

  hi TabLineSel cterm=bold gui=bold

  if &bg == 'light'
    if &t_Co > 8
      hi StatusLine cterm=none ctermbg=15 ctermfg=0
      hi StatusLineNC cterm=none ctermbg=15 ctermfg=7
    endif
  endif
endfunction
