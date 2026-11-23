" Configuration related to quickfix and location lists
" Maintainer: Danil Golovachev <danithecake@gmail.com>
" Last Change:  2020 Mar 27

" if exists("g:qf_stats")
"   finish
" endif

let g:qfstat = {'errors': 0, 'warnings': 0, 'all': 0}

function! s:get_qfstat()
  let g:qfstat['errors'] = len(filter(getqflist(), 'v:val.type ==? "e"'))
  let g:qfstat['warnings'] = len(filter(getqflist(), 'v:val.type ==? "w"'))
  let g:qfstat['all'] = g:qfstat.errors + g:qfstat.warnings
endfunction

augroup qfstats
  autocmd!
  autocmd QuickFixCmdPost * call s:get_qfstat()
  autocmd QuickFixCmdPost [^l]* echo 'QuickFix list: '.getqflist({'size': 1}).size.' items'
  autocmd QuickFixCmdPost [l]* echo 'Location list: '.getloclist('.', {'size': 1}).size.' items'
augroup END
