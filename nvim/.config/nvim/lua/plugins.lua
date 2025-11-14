-- Bootstrap lazy.nvim(auto install)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.notify("Error cloning lazy.nvim:\n" .. output, vim.log.levels.ERROR)
    return
  end
  vim.notify("lazy.nvim installed successfully", vim.log.levels.INFO)
end
vim.opt.rtp:prepend(lazypath)

local lazy_cmd = require('lazy.view.config').commands

vim.lsp.enable('lua_ls')

-- Setup lazy.nvim
require('lazy').setup({
  -- check if there are plugins to be updated
  checker = { enabled = true },
  -- ui
  require('plugins.colorscheme'),     -- colorscheme
  require('plugins.indent'),          -- show indent line
  require('plugins.noice'),           -- popup notice
  require('plugins.bufferline'),      -- buffer line
  require('plugins.statusline'),      -- statusline
  require('plugins.windows-separator'),   -- more distinguishable separators
  require('plugins.smear-cursor'),
  require('plugins.treesitter'),      -- better highlight and indent
  require('plugins.gitsigns'),        -- show git signs in files
  -- lsp related
  require('plugins.auto-complete'),   -- no need to explain
  -- debug
  require('plugins.dap'),
  require('plugins.dap-view'),
  -- edit
  require('plugins.auto-pairs'),      -- auto pairs, tab to escape, colorful brackets
  require('plugins.comment'),         -- smart gc
  require('plugins.surround'),        -- add/change/remove surround
  require('plugins.undo'),            -- undo tree
  require('plugins.markdown'),        -- preview, table mode
  require('plugins.trim-space'),      -- auto remove space in the end
  require('plugins.trouble'),         -- showing diagnostics, references, quickfix and so on
  -- navigation
  -- require('plugins.search'),          -- better f, t, and word-search
  require('plugins.yazi'),            -- file manager
  require('plugins.outline'),         -- code outline window
  -- tools
  require('plugins.leetcode'),
  require('plugins.snacks'),
})

-- my custom plugins
require('custom_plugins.compile-run')
require('custom_plugins.smart-jk')
-- require('custom_plugins.<++>')
-- require('custom_plugins.<++>')
-- require('custom_plugins.<++>')
-- require('custom_plugins.<++>')
