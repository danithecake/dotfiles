--
-- General
--
vim.cmd('source ~/.vimrc')

--
-- Plugins
--
-- UI
vim.cmd('Plugin "https://github.com/projekt0n/github-nvim-theme"')
vim.cmd('Plugin "https://github.com/norcalli/nvim-colorizer.lua"')
-- LSP
vim.cmd('Plugin "https://github.com/neovim/nvim-lspconfig"')

require('plugins.init')
