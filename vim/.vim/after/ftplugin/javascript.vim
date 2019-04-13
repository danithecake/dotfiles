setlocal include=from
setlocal suffixesadd=.js,.jsx
let &define='export\s\(default\s\)\?\(var\|let\|const\|function\|class\)\s'

setlocal includeexpr=findfile(expand('<cword>'),\ finddir(v:fname).'**')
