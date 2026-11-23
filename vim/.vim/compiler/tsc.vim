" Vim compiler plugin
" Language:     TypeScript
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "tsc"

set errorformat+=%f(%l\\,%c):\ %t%.%#:\ %m
let &makeprg = get(g:, 'tsc_makeprg', 'tsc %')
