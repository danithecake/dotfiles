command! -range=% MDPreview sil! <line1>,<line2>w !md2html | pipebrwsr

nmap <leader>mp <Cmd>MDPreview<CR>
xmap <leader>mp <Cmd>'<,'>MDPreview<CR><C-c>

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1
