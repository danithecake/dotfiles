let g:greppath = get(g:, 'greppath', '.')
let g:grepout = get(g:, 'grepout', tempname())
let s:grepprg = &grepprg

function! s:set_grepprg(grepprg) abort
  if !empty(a:grepprg)
    let s:grepprg = a:grepprg
  endif

  if !empty($TMUX)
    let l:grepprg = s:grepprg.' > '.g:grepout

    if executable('tvix')
      let l:grepprg .= '; env TVIX_VIMPANE='
        \ .tmux#paneid()
        \ .' tvix '
        \ .(getcmdline() =~# 'l\@<!grep' ? '--qff' : '--llf')
        \ .' '
        \ .g:grepout
    endif

    noautocmd let &grepprg = 'tmux neww -d -a -t:$ -n grep '.shellescape(l:grepprg)
  endif

  return ''
endfunction

cnoremap <expr> grpg<C-J> <SID>set_grepprg('grep -rnE $*')
" cnoremap grpa<C-J> <C-R>=g:greppath<CR><C-R>=setcmdpos(len(getcmdline())-len(g:greppath))<CR><BS>
cnoremap grpa<C-J> <C-R>=g:greppath<CR><C-R>=setcmdpos(len(getcmdline())-len(g:greppath))<CR><BS>
" cmap gr<C-J> sil! grep! grpg<C-J> grpa<C-J>
" cmap lgr<C-J> sil! lgrep! grpg<C-J> grpa<C-J>
cmap gr<C-J> grep!  grpa<C-J>
cmap lgr<C-J> lgrep!  grpa<C-J>
nmap <leader>gq :gr<C-J>
nmap <leader>gl :lgr<C-J>

augroup grep
  autocmd!
  autocmd VimEnter * set grepprg=grep\ -rnE\ $*
  " autocmd VimEnter * call s:set_grepprg('grep -rnE $*')
  " autocmd VimLeavePre * if (filereadable(g:grepout)) | call delete(g:grepout) | endif
  " autocmd OptionSet grepprg call s:set_grepprg(v:option_new)
augroup END
