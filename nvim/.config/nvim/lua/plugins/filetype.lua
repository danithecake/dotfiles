local augroup = vim.api.nvim_create_augroup('UserFileTypeConfig', {})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'typescript',
  callback = function()
    vim.opt.foldmethod = 'syntax'
  end
})
