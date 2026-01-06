return {
    "mbbill/undotree",
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle UndoTree" },
    },
    config = function()
        vim.g.undotree_DiffAutoOpen = 1
        vim.g.undotree_DiffAutoOpen = 1 -- auto open diff window
        --  undotree window get focus
        vim.g.undotree_SetFocusWhenToggle = 1
        -- using `d` instead of `days` to save some space
        vim.g.undotree_ShortIndicators = 1
        vim.g.undotree_WindowLayout = 2 -- using layout 2
        vim.g.undotree_SplitWidth = 32 -- undotree window size
        vim.g.undotree_DiffpanelHeight = 6 -- diff window height

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "undotree",
            callback = function()
                local opts = { buffer = true, silent = true }
                vim.keymap.set("n", "k", "<plug>UndotreeNextState", opts)
                vim.keymap.set("n", "j", "<plug>UndotreePreviousState", opts)
            end,
        })
    end,
    -- use cmdline to toggle
    -- vim.keymap.set("n", "<leader>5", vim.cmd.UndotreeToggle),
}

-- undotree window layout 2
-- +----------+------------------------+
-- |          |                        |
-- |          |                        |
-- | undotree |                        |
-- |          |                        |
-- |          |                        |
-- +----------+------------------------+
-- |                                   |
-- |   diff                            |
-- |                                   |
-- +-----------------------------------+
