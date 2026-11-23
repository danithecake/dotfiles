nnoremap <buffer><silent> <CR> :exec 'call win_gotoid(b:target_win) \| edit '.expand('<cfile>')<CR>
