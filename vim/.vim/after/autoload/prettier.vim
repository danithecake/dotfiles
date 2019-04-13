if !executable('prettier')
  finish
endif

let g:prettier_parser = 'babylon'

function! prettier#Format()
  let cur_pos = getpos('.')

  exec '%!prettier --stdin --parser '.g:prettier_parser.' 2>/dev/null %'

  call setpos('.', cur_pos)

  unlet cur_pos
endfunction
