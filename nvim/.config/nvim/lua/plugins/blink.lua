return {
    "Saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "xzbdmw/colorful-menu.nvim",
    },
    event = { "BufReadPost", "BufNewfile" },
    version = "1.*",
    opts = {
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            -- 'prefix' will fuzzy match on the text before the cursor
            -- 'full' will fuzy match on the text before & after the cursor
            keyword = { range = "full" },
            -- select automatically, because I use <C-y> to insert, and don't auto insert
            list = { selection = { preselect = true, auto_insert = false } },
            documentation = { -- no documentation showed
                auto_show = true,
                auto_show_delay_ms = 500,
                -- enable this if high CPU usage
                -- treesitter_highlighting = false,
            },
            menu = {
                auto_show = true,
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },

        keymap = {
            preset = "none", -- disable the default keymap
            -- use <C-n>/<C-p> to select suggestions
            ["<C-N>"] = { "select_next", "fallback" },
            ["<C-P>"] = { "select_prev", "fallback" },
            ["<C-Y>"] = { "accept", "fallback" },
            -- use <Tab>/<S-Tab> to edit snippets to avoid confliction
            ["<Tab>"] = { "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
        },

        -- use noice's cmdline menu
        cmdline = {
            enabled = false,
        },

        appearance = { nerd_font_variant = "mono" },
    },
}
