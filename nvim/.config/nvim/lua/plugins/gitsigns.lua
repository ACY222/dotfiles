return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "-" },
            topdelete = { text = "¯" },
            changedelete = { text = "~_" },
            untracked = { text = "┆" },
        },

        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- next hunk
            map("n", "]h", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, "Next Hunk")

            -- previous hunk
            map("n", "[h", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, "Prev Hunk")

            map("n", "ghs", gs.stage_hunk, "Stage Hunk")
            map("n", "ghr", gs.reset_hunk, "Reset Hunk")
            map("n", "ghp", gs.preview_hunk, "Preview Hunk")

            -- check the git history of current line
            map("n", "ghb", function()
                gs.blame_line({ full = true })
            end, "Blame Line")
            -- git diff
            map("n", "ghd", gs.diffthis, "Diff This")
        end,
    },
}
