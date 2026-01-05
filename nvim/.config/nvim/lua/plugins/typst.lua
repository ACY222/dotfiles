return {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    build = function()
        require("typst-preview").update()
    end,
    opts = {
        follow_cursor = true,
        dependencies_bin = "tinymist",
    }, -- lazy.nvim will implicitly calls `setup {}`
}
