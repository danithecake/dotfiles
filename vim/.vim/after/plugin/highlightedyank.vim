if exists('g:loaded_highlightedyank')
  if !exists('##TextYankPost')
    map y <Plug>(highlightedyank)
  endif
endif
