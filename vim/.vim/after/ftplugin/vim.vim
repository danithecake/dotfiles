let s:did_syntax = 0

finish

augroup vim
   autocmd! * <buffer>
   autocmd InsertEnter <buffer>
    \ if !s:did_syntax |
      \ syntax on | call syntaxcomplete#Complete(0, '0') | syntax off | let s:did_syntax = 1 |
    \ endif
augroup END
