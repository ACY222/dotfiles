return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        on_attach = function(bufnr)
            -- banned in some filetypes
            local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
            if ft == "typst" or ft == "markdown" then
                return
            end

            -- use `{` and `}` to jump between functions
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
    },
}
