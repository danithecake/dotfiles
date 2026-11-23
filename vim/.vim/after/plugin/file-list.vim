let s:winbuf_map = {}

function! s:OpenFileList(mods)
  let t_winid = win_getid()
  let fl_bufnr = get(s:winbuf_map, t_winid, 0)

  if !fl_bufnr || !buflisted(fl_bufnr)
    exec a:mods.' new'

    let &l:buftype = 'nofile'
    let &l:filetype = 'file-list'

    let s:winbuf_map[t_winid] = bufnr()
    let b:target_win = t_winid

    return
  endif

  let fl_winnr = bufwinnr(fl_bufnr)

  if win_screenpos(fl_winnr) == [0,0]
    exec a:mods.' split | buffer '.fl_bufnr
  else
    exec fl_winnr.'wincmd w'
  endif
endfunction

command! -bar FileListOpen call s:OpenFileList('<mods>')
