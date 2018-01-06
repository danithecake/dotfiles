aug vim_one_overrides
  au!
  au ColorScheme * call VimOneOverrides(g:colors_name)
aug END

fu! VimOneOverrides(colors)
  if a:colors ==# 'one'
    call one#highlight('Folded', '494b53', 'fafafa', '')
    call one#highlight('IncSearch', 'fafafa', 'd0d0d0', 'bold')
    call one#highlight('Search', '494b54', 'd0d0d0', 'bold')
    call one#highlight('DiffAdd',     '50a14f', 'fafafa', '')
    call one#highlight('DiffChange',  '986801', 'fafafa', '')
    call one#highlight('DiffDelete',  'e45649', 'fafafa', '')
    call one#highlight('DiffText',    '4078f2', 'fafafa', '')
    call one#highlight('DiffAdded',   '50a14f', 'fafafa', '')
    call one#highlight('DiffFile',    'e45649', 'fafafa', '')
    call one#highlight('DiffNewFile', '50a14f', 'fafafa', '')
    call one#highlight('DiffLine',    '4078f2', 'fafafa', '')
    call one#highlight('DiffRemoved', 'e45649', 'fafafa', '')
  endif
endfu

call VimOneOverrides(g:colors_name)
