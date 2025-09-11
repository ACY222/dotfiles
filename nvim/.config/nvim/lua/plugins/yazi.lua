-- integrate yazi with nvim
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      -- Open in the current working directory
      "<C-Y>",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      -- you can also use the following keymap
      -- o to edit,
      show_help = "~",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-h>",
      send_to_quickfix_list = "<c-q>",
    },
  },
}
