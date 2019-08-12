" Vim compiler plugin
" Language:     Bash
" Maintainer:   https://github.com/danithecake
" URL:          https://github.com/danithecake/dotfiles

if exists("current_compiler")
  finish
endif
let current_compiler = "shellcheck"

setlocal makeprg=shellcheck\ -f\ gcc\ $*\ %:S
setlocal errorformat+=
  \%f:%l:%c:\ %trror:\ %m,
  \%f:%l:%c:\ %tarning:\ %m,
  \%I%f:%l:%c:\ note:\ %m
