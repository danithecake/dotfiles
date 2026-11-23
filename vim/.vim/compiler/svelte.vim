" Vim compiler plugin
" Language:     Svelte
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "svelte"

let s:errorformat = &errorformat

set errorformat=%E%f:%l:%c
set errorformat+=%CError:\ %m
set errorformat+=%W%f:%l:%c
set errorformat+=%CWarning:\ %m
set errorformat+=%I%f:%l:%c
set errorformat+=%CHint:\ %m
set errorformat+=%Z

let &errorformat .= s:errorformat

let &makeprg = get(g:, 'tsc_makeprg', 'svelte-check')
