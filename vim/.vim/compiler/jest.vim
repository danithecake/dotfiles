" Vim jest compiler plugin
" Language:     JavaScript
" Maintainer:   Danil Golovachev <danithecake@gmail.com>
" URL:          https://github.com/danithecake/dotfiles
" Last Change:  2020 May 20

if exists("current_compiler")
  finish
endif
let current_compiler = "jest"

" setlocal errorformat=%.%#\ at\ %f:%l:%c,%.%#\ at\ %.%#(%f:%l:%c)
setlocal errorformat=%.%#\ at\ %.%#(%f:%l:%c),%-A%.%#
let &l:makeprg = get(g:, 'jest_makeprg', 'jest -- %')
