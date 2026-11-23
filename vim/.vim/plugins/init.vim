"
" Plugins
"
let g:plugs_path = $VIMPLUGS
filetype plugin on
filetype indent off
let s:pathogen = expand(g:plugs_path.'/vim-pathogen/autoload/pathogen.vim')

command! -nargs=1 Plugin silent

if filereadable(s:pathogen)
  exec 'source '.s:pathogen

  command! -nargs=1 Plugin call pathogen#infect(expand(g:plugs_path.'/'.split(<args>, '/')[-1]))

  " Langs
  " Plugin 'https://github.com/prabirshrestha/async.vim'
  " Plugin 'https://github.com/prabirshrestha/vim-lsp'

  " Tools
  Plugin 'https://github.com/Shougo/neosnippet.vim'
  Plugin 'https://github.com/machakann/vim-highlightedyank'
  Plugin 'https://github.com/justinmk/vim-dirvish'
  Plugin 'danithecake/tvix'
  " Disable netrw
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
endif
unlet s:pathogen
