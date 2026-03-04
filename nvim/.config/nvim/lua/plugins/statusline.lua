return {
    "nvim-lualine/lualine.nvim",
    -- | A | B | C |             | X | Y | Z |
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            -- then there won't be statusline for inactive sections
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            -- git information first
            lualine_a = { "branch", "diff" },
            lualine_b = {
                {
                    "filename",
                    filestatus = true,
                    newfile_status = true,
                    -- 0: no path, 1: relative path, 2: absolute path
                    -- 3: absolute path, ~ as home, 4: parent_dir/filename
                    path = 4,
                    shorting_target = 40, -- the max length
                },
            },
            lualine_c = {
                {
                    "diagnostics",
                    symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                },
            },
            lualine_x = { "lsp_status" },
            lualine_y = { "filesize" },
            lualine_z = { "location", "progress" },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
