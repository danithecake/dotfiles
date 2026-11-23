" Watch on file chanes and run callback commands
" Maintainer: Danil Golovachev <danithecake@gmail.com>
" Last Change:  2020 Mar 27

let s:files = {}

function! s:check() abort
  for l:file in values(s:files)
    if getftime(l:file.name) <= l:file.ftime
      continue
    endif

    execute join(l:file.cmds, ' | ')

    let l:file.ftime = getftime(l:file.name)
  endfor
endfunction

function! watchfile#check() abort
  for l:file in values(s:files)
    execute join(l:file.cmds, ' | ')

    let l:file.ftime = getftime(l:file.name)
  endfor
endfunction

function! watchfile#watch(file, cmds) abort
  let s:files[a:file] = {'name': a:file, 'ftime': 0, 'cmds': a:cmds}
endfunction

function! watchfile#files() abort
  return s:files
endfunction

augroup watchfile
  autocmd!
  " autocmd CursorHold,CursorHoldI,CmdlineLeave,InsertLeave * ++nested :call s:check()
  " autocmd Signal SIGUSR1 ++nested call s:check()
  autocmd Signal SIGUSR1 ++nested call watchfile#check()
augroup END
