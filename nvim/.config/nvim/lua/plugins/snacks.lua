return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
      },
      explorer = {
        enabled = true,
        auto_close = true,
        layout = {
          cycle = false,
        }
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        matchers = {
          frequency = true,
          cwd_bonus = true,
        },
        formatters = {
          file = {
            filename_first = false,
            filename_only = false,
            icon_width = 2,
          },
        },
        layout = {
          preset = "telescope",
          cycle = false,
        },
        layouts = {
          select = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.6,
              min_width = 80,
              height = 0.4,
              min_height = 10,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
            },
          },
        },
        telescope = {
          reverse = true,
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
              { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.5,
              border = "rounded",
              title_pos = "center",
            },
          },
        },
      },
      quickfile = { enabled = true },   -- render the file as soon as possible
      -- this make scrolling smooth, but slow. I don't like this
      -- scroll = { enabled = true },
      words = { enabled = true },       -- highlight current words
    },
    keys = {
      -- File Explorer
      { "<leader>e", function() require("snacks").explorer() end, desc = "Open Snakcks File Explorer" },
      { "<leader>rf", function() require("snacks").rename.rename_file() end, desc = "Rename File" },
      -- Use snacks's picker to replace telescope
      -- { "<C-o>", function() require("snacks").picker.recent() end, desc = "Find Recent Used Files" },
      -- Its performance is disappointing, and <C-o> is useful in other place
      { "<C-n>", function() require("snacks").picker.files() end, desc = "Find Files by Name" },
      { "<C-c>", function() require("snacks").picker.grep() end, desc = "Find Files by Contents" },
      { "<leader>hp", function() require("snacks").picker.help() end, desc = "Help Pages" },
      -- this is wonderful, enable fuzzy finding
      { "<leader>km", function() require("snacks").picker.keymaps() end, desc = "Keymaps" },
      -- this helps you compare different colorschemes
      { "<leader>cs", function() require("snacks").picker.colorschemes() end, desc = "Pick Colorschemes" },
      -- Other
    },
  },
}
