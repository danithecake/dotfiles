aug vim_one_overrides
  au!
  au ColorScheme * call VimOneOverrides(g:colors_name)
aug END

fu! VimOneOverrides(colors)
  if a:colors ==# 'one'
    call one#highlight('Folded', '494b53', 'fafafa', '')
  endif
endfu

call VimOneOverrides(g:colors_name)
