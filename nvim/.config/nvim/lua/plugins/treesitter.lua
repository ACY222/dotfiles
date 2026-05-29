return {
    {
        -- highlight, indent, fold function by syntax analyzing
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            auto_install = false,
            ensure_installed = {
                -- main languages
                "c",
                "cpp",
                "markdown",
                "typst",
                -- config languages
                "lua",
                "vim",
            },
            highlight = {
                enable = true,
                -- disable highlight for large files
                disable = function(lang, buf)
                    if lang == "latex" or lang == "tex" then
                        return true
                    end
                    local max_filesize = 100 * 1024 -- 100 KB
                    local buf_name = vim.api.nvim_buf_get_name(buf)

                    local stats = vim.uv.fs_stat(buf_name)
                    if stats and stats.size > max_filesize then
                        return true
                    end

                    -- if there super long lines
                    local line_count = vim.api.nvim_buf_line_count(buf)
                    if line_count > 5000 then
                        return true
                    end
                end,
            },
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.opt.autoindent = false
        end,
    },
    {
        -- show the context of the currently visible buffer contents
        -- show you which function you are looking at
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        opts = {
            max_lines = 3,
            min_window_height = 20,
            line_numbers = true,
            multiline_threshold = 1,
            -- Which context lines to discard if `max_lines` is exceeded.
            trim_scope = "outer",
            -- Line used to calculate context. Choices: 'cursor', 'topline'
            mode = "cursor",
        },
    },
}
