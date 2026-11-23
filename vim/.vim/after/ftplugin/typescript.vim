" runtime! ftplugin/javascript.vim syntax/javascript.vim
runtime! ftplugin/javascript.vim

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

silent! compiler tsc
