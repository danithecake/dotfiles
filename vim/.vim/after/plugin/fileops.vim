" Files operations utilities
" Maintainer: Daniel Golovachev <danithecake@gmail.com>

if !get(g:, 'loaded_tvix', 0)
 finish
endif

" Open files in tmux popup with vifm
if executable('vifm')
  function! s:ofiles(dir)
    let l:files = tvix#popup(
      \ [' vifm --choose-files - '.expand(a:dir)],
      \ {'w':'80%','h':'80%','redir':'>'})

    return substitute(l:files, getcwd(), '.', 'g')
  endfunction

  command! -nargs=? -complete=dir -bar TvixOF sil! exec 'next '.<SID>ofiles(<q-args>)

  nnoremap <silent> <Leader>of :TvixOF %:p:h<CR>
  cabbrev tof TvixOF %:p:h
endif

" Find files in tmux popup with g:findprg and fzf
if executable('fzf')
  function! s:ffiles()
    let shell = ' /usr/bin/env bash -i -c '
    let cmd = get(g:, 'findprg', 'find').(exists($FINDOPTS) ? $FINDOPTS : '').' | fzf --scheme=path --height=-1'
    let l:files = tvix#popup(
      \ [shell.'"'.cmd.'"'],
      \ {'w':'80%','h':'80%','redir':'>'})

    return substitute(l:files, getcwd(), '.', 'g')
  endfunction

  nnoremap <silent> <Leader>ff :sil! execute 'next '.<SID>ffiles()<CR>
endif
