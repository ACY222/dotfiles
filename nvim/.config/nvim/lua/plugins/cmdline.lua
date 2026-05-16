return {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = {
        "romgrk/fzy-lua-native",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local wilder = require("wilder")

        wilder.setup({
            modes = { ":", "/", "?" },
        })

        wilder.set_option("pipeline", {
            wilder.branch(
                wilder.cmdline_pipeline({
                    fuzzy = 1,
                }),
                wilder.search_pipeline()
            ),
        })

        wilder.set_option(
            "renderer",
            wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                border = "rounded",
                pumblend = 20,
                highlights = {
                    border = "Normal",
                },
                left = { " ", wilder.popupmenu_devicons() },
                right = { " ", wilder.popupmenu_scrollbar() },
            }))
        )

        vim.keymap.set("c", "<C-n>", function()
            return wilder.in_context() and wilder.next() or "<C-n>"
        end, { expr = true, replace_keycodes = true })

        vim.keymap.set("c", "<C-p>", function()
            return wilder.in_context() and wilder.previous() or "<C-p>"
        end, { expr = true, replace_keycodes = true })
    end,
}
