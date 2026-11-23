-- local lspconfig = require('lspconfig')
local augroup = vim.api.nvim_create_augroup('UserLspConfig', {})

vim.lsp.set_log_level('debug')

vim.lsp.config['efm'] = (
  (function()
    local languages = {
      javascript = { 'javascript', 'javascriptreact' },
      typescipt = { 'typescript', 'typescriptreact' },
      json = { 'json' },
      lua = { 'lua' },
      python = { 'python' },
      go = { 'go' },
    }

    return {
      on_attach = function()
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          pattern = '*',
          callback = function()
            if next(vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/formatting' })) ~= nil then
              local view = vim.fn.winsaveview()

              vim.lsp.buf.format()

              vim.fn.winrestview(view)
            end
          end,
        })
      end,
      on_detach = function()
        vim.api.nvim_clear_autocmds({
          event = 'BufWritePre',
          pattern = '*',
          group = augroup,
        })
      end,
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        codeAction = true,
      },
      settings = {
        rootMarkers = { '.git/' },
        languages = (function()
          local filetypes = {}

          vim
              .iter({
                languages.javascript,
                languages.typescipt,
                languages.json,
              })
              :flatten()
              :each(function(filetype)
                filetypes[filetype] = {
                  {
                    formatCommand = 'prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd}',
                    -- formatCommand = 'npx prettier --stdin-filepath "${INPUT}"',
                    -- formatCommand = 'biome format --use-editorconfig=true --stdin-file-path=${INPUT}',
                    formatStdin = true,
                    formatCanRange = true,
                    rootMarkers = {
                      '.prettierrc',
                      '.prettierrc.json',
                      '.prettierrc.js',
                      '.prettierrc.yml',
                      '.prettierrc.yaml',
                      '.prettierrc.json5',
                      '.prettierrc.mjs',
                      '.prettierrc.cjs',
                      '.prettierrc.toml',
                      'prettier.config.js',
                      'prettier.config.mjs',
                    },
                  },
                }
              end)

          vim.iter({ languages.lua }):flatten():each(function(filetype)
            filetypes[filetype] = {
              {
                formatCommand = 'stylua --stdin-filepath ${INPUT} ${--range-start:rowStart} ${--range-end:rowEnd} -',
                formatStdin = true,
                formatCanRange = true,
                rootMarkers = {
                  'stylua.toml',
                  '.stylua.toml',
                },
              },
            }
          end)

          vim.iter({ languages.python }):flatten():each(function(filetype)
            filetypes[filetype] = {
              {
                formatCommand = 'autopep8 -',
                formatStdin = true,
                rootMarkers = {
                  'pyproject.toml',
                  'setup.py',
                  'setup.cfg',
                  'requirements.txt',
                  'Pipfile',
                  'pyrightconfig.json',
                  '.git',
                },
              },
            }
          end)

          vim.iter({ languages.go }):flatten():each(function(filetype)
            filetypes[filetype] = {
              {
                formatCommand = 'gofmt',
                formatStdin = true,
              },
            }
          end)

          return filetypes
        end)(),
      },
      filetypes = vim
          .iter(vim
            .iter(pairs(languages))
            :map(function(_, filetype)
              return filetype
            end)
            :totable())
          :flatten()
          :totable(),
    }
  end)()
)
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        enable = true,
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr)
  end,
}
vim.lsp.config['ts_ls'] = {
  init_options = {
    completionDisableFilterText = true,
    documentFormatting = false,
    documentRangeFormatting = false,
  },
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
vim.lsp.config['eslint'] = {
  cmd = { 'eslint_d', '--stdin', '--fix-to-stdout' },
  settings = {
    rootWorkingDirectory = { mode = 'auto' },
    documentFormatting = false,
    documentRangeFormatting = false,
  },
  flags = {
    allow_incremental_sync = true,
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   buffer = bufnr,
    --   command = 'EslintFixAll',
    -- })
  end,
}
vim.lsp.config['gopls'] = {
  settings = {
    gopls = {
      staticcheck = true,
    },
    gofumpt = false,
  },
}
vim.lsp.config['pyright'] = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr)
  end,
}

vim.lsp.enable('efm')
vim.lsp.enable('lua_ls')
vim.lsp.enable('vimls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('gopls')
vim.lsp.enable('pyright')

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[ev.buf].completeopt = 'popup,menuone,fuzzy,noinsert'
    vim.keymap.set('n', '<Leader>li.', vim.lsp.buf.hover)
    vim.keymap.set('n', '<Leader>ld.', vim.diagnostic.open_float)
    vim.keymap.set('n', '<Leader>lda', vim.diagnostic.setqflist)
    vim.keymap.set('n', '<Leader>lgd', vim.lsp.buf.definition)
    vim.keymap.set('n', '<Leader>lfr', vim.lsp.buf.references)
    vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename)
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = augroup,
  callback = function()
    vim.cmd('setlocal tagfunc< omnifunc< completeopt<')
  end,
})
