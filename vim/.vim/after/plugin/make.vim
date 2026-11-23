" Additional file for make program output is used because &makeef can be
" deleted before async make process finishes.
" :help :make
let g:makeout = get(g:, 'makeout', tempname())

function! s:set_makeprg(makeprg) abort
  if !empty($TMUX)
    let l:makeprg = a:makeprg.' > '.g:makeout

    if executable('tvix')
      let l:makeprg .= '; env TVIX_VIMPANE='.tmux#paneid().' tvix --cmd "checktime"'
      let l:makeprg .= '; env TVIX_VIMPANE='.tmux#paneid().' tvix --qff '.g:makeout
    endif

    noautocmd let &makeprg = 'tmux neww -d -a -t:$ -n make '.shellescape(l:makeprg)
  endif
endfunction

augroup make
  autocmd!
  " autocmd VimEnter * call s:set_makeprg(&makeprg)
  " autocmd VimLeavePre * if filereadable(g:makeout) | call delete(g:makeout) | endif
  " autocmd OptionSet makeprg call s:set_makeprg(v:option_new)
augroup END
