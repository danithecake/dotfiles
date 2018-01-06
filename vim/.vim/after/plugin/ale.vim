if exists('g:loaded_ale_after')
  let g:ale_lint_on_save = 0
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_sign_error = 'x'
  let g:ale_sign_warning = '!'
  let g:ale_statusline_format = ['E:%d', 'W:%d', 'OK']
  let g:ale_javascript_eslint_executable = 'eslint_d'

  let &stl .= '[%{ALEGetStatusLine()}]'

  nmap <Leader>ep <Plug>(ale_previous_wrap)
  nmap <Leader>en <Plug>(ale_next_wrap)
endif
