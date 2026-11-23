" Buffers operations utilities
" Maintainer: Daniel Golovachev <danithecake@gmail.com>

" Wipeout buffers with deleted files
function! WipeOrphanBufs()
  for buf in filter(map(getbufinfo({'buflisted': 1}), 'v:val.bufnr'), '!filereadable(bufname(v:val))')
    execute 'sil! bwipeout! '.buf
  endfor
endfunction

command! WipeOrphanBufs call WipeOrphanBufs()
