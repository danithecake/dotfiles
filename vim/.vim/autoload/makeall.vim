" Vim function to collect output of multiple :make commands
" Language:     VimL
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

let s:qflists = {}

function! makeall#make(bang)
  exec 'make'.(a:bang ? '!' : '')

  let l:qflist = getqflist()
  let l:bufnr = bufnr('%')

  if len(l:qflist)
    let s:qflists[l:bufnr] = getqflist()
  else
    silent! call remove(s:qflists, l:bufnr)
  endif

  call setqflist([], 'r', {'title': &makeprg})

  for qflist in values(s:qflists)
    call setqflist([], 'a', {'items': qflist})
  endfor
endfunction
