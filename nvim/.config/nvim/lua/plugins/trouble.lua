return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    -- float windows
    float = {
      border = "rounded",
      size = 0.3,
    },
    focus = true,
    -- move to corresponding lines when moving cursor
    follow = true,
    -- preview window
    preview = {
      type = "split",
      relative = "win",
      position = "right",
      size = 0.3,
    },
  },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
}
