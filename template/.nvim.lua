-- .nvim.lua — Project-local Neovim config
-- This file is loaded automatically when you open Neovim in this directory.
-- It overrides global LSP settings to use the project's .venv binaries.


local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Register pyrefly if not already known
if not configs.pyrefly then
  configs.pyrefly = {
    default_config = {
      cmd = { '.venv/bin/pyrefly', 'lsp' },
      filetypes = { 'python' },
      root_dir = lspconfig.util.root_pattern(
        'pyrefly.toml', 'pyproject.toml', '.git'
      ),
    },
  }
end

-- Point both Python LSPs at this project's venv
vim.lsp.config('pyrefly', {
  cmd = { '.venv/bin/pyrefly', 'lsp' },
})

vim.lsp.config('ruff', {
  cmd = { '.venv/bin/ruff', 'server' },
})
