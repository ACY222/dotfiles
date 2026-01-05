return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
        require("flash").setup({
            -- f, F, t, T with labels
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        })
    end,
    keys = {
        {
            "<leader>w",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash to wherever you want using <leader>w",
        },
    },
}
