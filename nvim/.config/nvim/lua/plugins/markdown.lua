return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview",
      "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      -- don't auto-close when leaving the markdown file
      vim.g.mkdp_auto_close = 1
      -- refresh as I edit or move the cursor
      vim.g.mkdp_refresh_slow = 0
    end,
    ft = { "markdown" },
  },
  {
    'dhruvasagar/vim-table-mode',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[
        let g:table_mode_separator = '|'
        let g:table_mode_corner = '|'
        let g:table_mode_syntax = 0
      ]])
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function ()
      require("render-markdown").setup({
        sign = { enabled = false },
        code = {
          -- general
          width = 'block',
          min_width = 80,
          -- borders
          border = 'thin',
          left_pad = 1,
          right_pad = 1,
          -- language info
          position = 'left',
          language_icon = true,
          language_name = true,
          -- avoid making headings ugly
          highlight_inline = 'RenderMarkdownCodeInfo',
        },
        heading = {
          icons = { '󰼏  ', '󰎨  ', '󰼑  ', '󰎲  ', '󰼓  ', '󰎴  ' },
          position = 'inline',
          border = false,
          render_modes = true, -- keep rendering while inserting
          backgrounds = {},
        },
        checkbox = {
          unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownCodeFallback',
            scope_highlight = 'RenderMarkdownCodeFallback',
          },
          checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownCodeFallback',
            scope_highlight = nil,
          },
        },
        pipe_table = {
          alignment_indicator = '─',
          border = { '╭', '┬', '╮', '├', '┼', '┤', '╰', '┴', '╯', '│', '─' },
        },
        link = {
          wiki = { icon = ' ', highlight = 'RenderMarkdownWikiLink', scope_highlight = 'RenderMarkdownWikiLink' },
          image = ' ',
          custom = {
            github = { pattern = 'github', icon = ' ' },
            youtube = { pattern = 'youtube', icon = ' ' },
          },
          hyperlink = ' ',
        },
        anti_conceal = {
          disabled_modes = { 'n' },
          ignore = {
            bullet = true, -- render bullet in insert mode
            head_border = true,
            head_background = true,
          },
        },
        -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
        win_options = { concealcursor = { rendered = 'nvc' } },
        completions = {
          blink = {
            enabled = true
          },
        },
      })
    end
  }
}
