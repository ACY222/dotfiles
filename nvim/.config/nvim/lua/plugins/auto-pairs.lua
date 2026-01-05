return {
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        opts = {
            keys = {
                -- enable $ in markdown files
                ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = { "markdown", "typst" } },
                ["`"] = { escape = false, close = true, pair = "``", enabled_filetypes = { "markdown", "typst" } },

                ["<"] = {
                    escape = true,
                    close = true,
                    pair = "<>",
                    disable_command_mode = true,
                    disabled_filetypes = { "c", "cpp", "python", "rust" },
                },
                [">"] = {
                    escape = true,
                    close = false,
                    pair = "<>",
                    disable_command_mode = true,
                    disabled_filetypes = { "c", "cpp", "python" },
                },
                ["'"] = { escape = false, close = false, pair = "''" },
                -- in vim, " is used to comment
                ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = { "vim" } },
            },
        },
    },
    -- {
    --   'ijimiji/tabout.nvim',
    --   event = 'InsertEnter',
    --   -- I need to enable tabout from $$
    -- },
    {
        -- it does what he said, rainbow-delimiters(brackets)
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("rainbow-delimiters.setup").setup({
                highlight = {
                    -- the order is bottom-up
                    "RainbowDelimiterCyan",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterRed",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                },
            })
        end,
    },
}
