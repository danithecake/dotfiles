let b:errors = len(filter(getqflist(), 'v:val.type ==? "e"'))
let b:warns = len(filter(getqflist(), 'v:val.type ==? "w"'))

if !get(g:, 'qf_disable_statusline')
  let b:undo_ftplugin = "set stl<"
  let b:qf_type = getqflist({'winid': 1}).winid == win_getid() ? 'QFX' : 'LOC'

  let &l:statusline = '%{b:qf_type}'
        \ .' %<%{get(w:,"quickfix_title","")}'
        \ .'%='
        \ .'%l:%L'
        \ .'%{b:errors || b:warns ? " " : ""}'
        \ .'%#ErrorMsg#%{b:errors ? "  ".b:errors." " : ""}%##'
        \ .'%#WarningMsg#%{b:warns ? "  ".b:warns." " : ""}%##'
endif
