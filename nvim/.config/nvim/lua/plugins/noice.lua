return {
    -- nvim icons library
    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss All Notifications",
            },
        },
        opts = {
            timeout = 1000,
            strages = "fade",
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            background_colour = "#282A36",
            render = "default",
        },
    },

    -- provides better UI interface for messages, cmdline, popupmenu
    -- It works well, but no auto-suggestions before I typing tab
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim", -- a ui library
            "rcarriga/nvim-notify",
        },

        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },

            -- display cmdline and popupmenu together
            views = {
                cmdline_popup = {
                    position = {
                        row = 5, -- at the 5th row from the top
                        col = "50%", -- stay in the middle
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },

                popupmenu = {
                    enabled = true,
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        },
    },
}
