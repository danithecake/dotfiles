" Helpers, utilities and mappings for Git integration
" Maintainer: Danil Golovachev <danithecake@gmail.com>

function! s:yank_remote_link(reg, ...) abort
  let l:git_root = get(g:, 'git_root', '\.')
  let l:git_main_branch = get(g:, 'git_main_branch', 'master')
  let l:git_current_branch = system('git branch --show-current')
  let l:git_remote_url = get(g:, 'git_remote_url', 'https://github.com/:branch:/')
  let l:link = substitute(
          \ l:git_remote_url,
          \ ':branch:',
          \ get(l:, 'git_current_branch', l:git_main_branch),
          \ '')
        \ .expand('%:.')

  if has_key(a:, 1)
    let l:link .= '#L'.(type(a:1) ? line(a:1) : a:1)
  endif

  if has_key(a:, 2)
    let l:link .= '-L'.(type(a:2) ? line(a:2) : a:2)
  endif

  call setreg(a:reg, l:link)

  return l:link
endfunction

function! s:handle_nmap(link)
  echo 'Copied: '.a:link
endfunction

function! s:handle_xmap(link)
  echo 'Copied: '.a:link
  sleep
  normal 
endfunction

nmap <leader>ygf <Cmd>call <SID>handle_nmap(<SID>yank_remote_link(v:register))<CR>
nmap <leader>ygl <Cmd>call <SID>handle_nmap(<SID>yank_remote_link(v:register, '.'))<CR>
xmap <leader>ygl <Cmd>call <SID>handle_xmap(<SID>yank_remote_link(v:register, line('v'), '.'))<CR>

nmap <leader>xygf "*<leader>ygf
nmap <leader>xygl "*<leader>ygl
xmap <leader>xygl "*<leader>ygl

nmap <leader>gaf <Cmd>w <Bar> call system('git add '.expand('%')) <Bar>
  \ if v:shell_error == 0 <Bar> echo 'File staged' <Bar> endif<CR>
nmap <leader>gbl <Cmd> exec '!git blame -L '.line('.').',+1 -- '.expand('%')<CR>

if get(g:, 'loaded_tvix', 0)
  nmap <leader>gdf <Cmd>call tvix#execute([' git diff '.expand('%')], {})<CR>
  nmap <leader>glf <Cmd>call tvix#execute([' git log --follow -- '.expand('%')], {})<CR>
  nmap <leader>gpf <Cmd>call tvix#execute([' git add -p '.expand('%')], {})<CR>
endif
