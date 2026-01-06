return {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>w",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash to wherever you want using <leader>w",
        },
        -- How to use: <operate> r <chars> <motion>
        -- e.g.: if you want to copy the `mode` 3 lines below, you can use
        -- `y + r + mode + label + w` the last three parts are used to jump to
        -- the word
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Operate Remotely Without Leaving Where The Cursor Is",
        },
    },
    opts = {
        jump = {
            jumplist = true,
        },
        modes = {
            -- use enhanced `t`, `f` in single line
            char = {
                enabled = true,
                jump_labels = true,
                multi_line = false,
            },
            -- if you wanna jump to a specific word, use flash.jump directly
            search = {
                enabled = false,
            },
        },
    },
}
