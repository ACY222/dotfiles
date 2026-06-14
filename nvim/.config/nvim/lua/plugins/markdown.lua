return {
    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },

        build = function()
            vim.fn["mkdp#util#install"]()
        end,

        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_start = 0
            -- don't auto-close when leaving the markdown file
            vim.g.mkdp_auto_close = 1
            -- refresh as I edit or move the cursor
            vim.g.mkdp_refresh_slow = 0
        end,
    },
}
