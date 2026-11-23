" Vim compiler plugin
" Language:     Bash
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "shellcheck"

CompilerSet errorformat+=%f:%l:%c:\ %trror:\ %m,
CompilerSet errorformat+=%f:%l:%c:\ %tarning:\ %m,
CompilerSet errorformat+=%I%f:%l:%c:\ note:\ %m
CompilerSet makeprg=shellcheck\ -f\ gcc\ $*\ %:S
