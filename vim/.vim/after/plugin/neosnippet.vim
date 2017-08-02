if exists('g:loaded_neosnippet')
  let g:neosnippet#disable_runtime_snippets = {'_': 1}
  let g:neosnippet#snippets_directory = $NEOSNIPPETS

  imap <C-j> <Plug>(neosnippet_expand_or_jump)
  smap <C-j> <Plug>(neosnippet_expand_or_jump)
  xmap <C-j> <Plug>(neosnippet_expand_target)
endif
