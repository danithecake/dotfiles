if !exists('g:terma_loaded') || !g:terma_loaded
  exit
endif

function! FileFinder(...)
  let l:find_cmd = 'find '
        \ .join(get(g:, 'finder_include_paths', ['.']))
        \ .' -type f '
        \ .join(map(copy(get(g:, 'finder_exclude_paths', [])), {i, val -> '-not -path "'.val.'"'}))
        \ .' -not -path "'.fnamemodify(expand('%'), ':.').'" | fzy'

  call terma#split(l:find_cmd, {
        \ 'on_stdout': {stdout -> execute('drop '.stdout[0])},
        \ 'stderr': 0,
        \ 'size': 12
        \ })
endfunction

function! FilePicker(...)
  function! OnPick(selection, ...)
    echomsg a:selection
    try
      execute 'drop '.readfile(a:selection)[0]
    catch
    finally
      call delete(a:selection)
    endtry
  endfunction

  let l:selection = tempname()

  try
    call terma#split(
          \ 'ranger '
          \ .expand('%:p:h')
          \ .' --selectfile='
          \ .expand('%')
          \ .' --choosefile='
          \ .l:selection,
            \ {
            \ 'maximize': 1,
            \ 'stdout': 0,
            \ 'stderr': 0,
            \ 'on_exit': function('OnPick', [l:selection])
            \ }
          \ )
  catch
    call delete(l:selection)
  endtry
endfunction

function! Grep(search, ...)
  let l:grep_cmd = 'grep -rnH "'
        \ .a:search
        \ .'" '
        \ .join(get(g:, 'grep_include_paths', ['.']))
  let l:HlSearch = function('matchadd', ['Search', '|\d*|.\{-}\zs'.a:search])

  if !get(g:, 'terma_loaded')
    execute substitute(l:grep_cmd, '\(grep\)', '\1!', '')

    call setqflist([], 'a', {'title': 'grep'})

    copen

    call l:HlSearch()

    return
  endif

  function! OnGrep(hlsearch, stdout, ...)
    echo

    let l:result = []

    for l:match in a:stdout
      let l:match_list = matchlist(l:match, '^\(.*\):\(\d\+\):\(.*\)$')

      call add(l:result, {
            \ 'filename': fnamemodify(l:match_list[1], ':p:.'),
            \ 'lnum': l:match_list[2],
            \ 'text': l:match_list[3],
            \ 'valid': 1,
            \ })
    endfor

    call setqflist(l:result, 'r')
    call setqflist([], 'a', {'title': 'grep'})

    copen

    call a:hlsearch()
  endfunction

  call terma#run(l:grep_cmd, {'on_exit': function('OnGrep', [l:HlSearch])})
endfunction
