return {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,

    opts = {
        transparent_bg = true,
        italic_comment = true,
        lualine_bg_color = "#44475a",
    },

    config = function(_, opts)
        local dracula = require("dracula")
        dracula.setup(opts)

        vim.cmd.colorscheme("dracula")
    end,
}
-- return {
--     -- colorscheme
--     "folke/tokyonight.nvim",
--     lazy = false, -- load it during startup
--     priority = 1000, -- load this before all other plugins
--     opts = {
--         style = "storm",
--         transparent = true,
--         terminal_colors = true,
--         styles = {
--             comment = { bold = true },
--             keywords = { italic = true },
--             sidebars = "transparent",
--             floats = "transparent",
--         },
--     },
--     config = function(_, opts)
--         local tokyonight = require("tokyonight")
--         tokyonight.setup(opts)
--         -- load the colorscheme here
--         vim.cmd.colorscheme("tokyonight")
--     end,
-- }
