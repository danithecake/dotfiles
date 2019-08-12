" Vim compiler plugin
" Language:     JavaScript
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "eslint"

setlocal errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %t%.%#-\ %m,%-G\ %#%.%#
let &l:makeprg = get(g:, 'eslint_makeprg', 'eslint --format compact %')
