" Vim compiler plugin
" Language:     JavaScript
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "prettier"

set errorformat+=[%t%.%#]%f:\ %m\ (%l:%c)
set errorformat+=%A[%t%.%#]\ %.%#\ in\ %f:
set errorformat+=%C[%.%#]\ %m\ at\ %l:%c
set errorformat+=%Z
set errorformat+=%-G\ %#
set errorformat+=%-G[%.%#]\ %.%#
let &makeprg = get(g:, 'prettier_makeprg', 'prettier --no-color --write %')
