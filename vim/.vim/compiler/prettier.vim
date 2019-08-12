" Vim compiler plugin
" Language:     JavaScript
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "prettier"

setlocal errorformat+=[%t%.%#]%f:\ %m\ (%l:%c),%-G\ %#,%-G[%.%#]\ %.%#
let &l:makeprg = get(g:, 'prettier_makeprg', 'prettier --write %')
