return {
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        opts = {
            keys = {
                -- enable $ in markdown files
                ["$"] = {
                    escape = true,
                    close = true,
                    pair = "$$",
                    enabled_filetypes = { "markdown", "typst" },
                    disable_command_mode = true,
                },
                ["`"] = {
                    escape = false,
                    close = true,
                    pair = "``",
                    enabled_filetypes = { "markdown", "typst" },
                    disable_command_mode = true,
                },

                ["<"] = {
                    escape = true,
                    close = true,
                    pair = "<>",
                    disable_command_mode = true,
                    disabled_filetypes = { "c", "cpp", "python", "rust", "typst", disable_command_mode = true },
                },
                [">"] = {
                    escape = true,
                    close = false,
                    pair = "<>",
                    disable_command_mode = true,
                    disabled_filetypes = { "c", "cpp", "python", disable_command_mode = true },
                },
                ["'"] = { escape = false, close = false, pair = "''", disable_command_mode = true },
                -- in vim, " is used to comment
                ['"'] = {
                    escape = true,
                    close = true,
                    pair = '""',
                    disabled_filetypes = { "vim" },
                    disable_command_mode = true,
                },
            },
        },
    },
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
