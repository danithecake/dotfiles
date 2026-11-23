if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal suffixesadd=.js,.jsx
" let &define='^\s*export\s\(default\s\)\?\(var\|let\|const\|function\|class\)\s'
let &define='^\s*\(var\|let\|const\|function\|class\)\s'

" setlocal includeexpr=findfile(expand('<cword>'),\ finddir(v:fname).'**')

setlocal expandtab softtabstop=2 textwidth=119
setlocal indentexpr=smartindent
setlocal foldmethod=syntax

silent! compiler prettier
silent! compiler eslint
setlocal makeprg<

let b:undo_ftplugin .= ' include< suffixesadd< define< indentexpr<'

highlight link jsxCloseString Normal
