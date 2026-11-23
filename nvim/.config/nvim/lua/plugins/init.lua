--
-- UI
--
require('github-theme').setup({
  options = {
    transparent = true,
    terminal_colors = false,
    dim_inactive = true,
  },
  groups = {
    all = {
      Cursor = { fg = 'fg1', bg = 'palette.cyan.bright' },
    },
    github_light = {
      DiagnosticFloatingHint = { fg = 'fg0' },
    },
  },
})
vim.cmd('colorscheme github_dark_dimmed')

--
-- FileType
--
require('plugins.filetype')

--
-- LSP
--
require('plugins.lsp')
