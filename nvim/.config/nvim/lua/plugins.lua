-- Bootstrap lazy.nvim(auto install)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.lsp.enable("lua_ls")

-- Setup lazy.nvim
require("lazy").setup({
    -- check if there are plugins to be updated
    checker = { enabled = true },
    -- ui
    require("plugins.colorscheme"), -- colorscheme
    require("plugins.indent"), -- show indent line
    require("plugins.bufferline"), -- buffer line
    require("plugins.statusline"), -- statusline
    require("plugins.windows-separator"), -- more distinguishable separators
    require("plugins.gitsigns"), -- show git signs in files
    -- lsp related
    require("plugins.lsp"),
    require("plugins.blink"),
    -- edit
    require("plugins.auto-pairs"), -- auto pairs, tab to escape, colorful brackets
    require("plugins.comment"), -- smart gc
    require("plugins.surround"), -- add/change/remove surround
    require("plugins.markdown"), -- preview, table mode
    require("plugins.typst"), -- typst preview
    require("plugins.trim-space"), -- auto remove space in the end
    require("plugins.cmdline"), -- enhance cmdline mode
    -- navigation
    require("plugins.flash"), -- enhanced f, t, and word-search
    -- tools
    require("plugins.snacks"),
    require("plugins.file_explorer"),

    -- unnecessary
    require("plugins.smear-cursor"),
    require("plugins.treesitter"), -- better highlight and indent

    require("plugins.lua"), -- lua support
    require("plugins.latex"), -- latex auto compile
    require("plugins.img-clip"), -- paste images in markup languages
    require("plugins.conform"), -- enable formatter
    require("plugins.trouble"), -- showing diagnostics, references, quickfix and so on

    require("plugins.outline"), -- code outline window
    require("plugins.leetcode"),
})

-- my custom plugins
require("custom_plugins.compile-run")
require("custom_plugins.smart-jk")
-- require('custom_plugins.<++>')
-- require('custom_plugins.<++>')
-- require('custom_plugins.<++>')
-- require('custom_plugins.<++>')
