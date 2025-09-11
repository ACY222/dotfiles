return {
  {
    'm4xshen/autoclose.nvim',
    event = 'InsertEnter',
    config = function()
      require('autoclose').setup({
        keys = {
          -- enable $ in markdown files
          ['$'] = { escape = true, close = true, pair = '$$',
            enabled_filetypes = { 'markdown' } },
          ['<'] = { escape = true, close = true, pair = '<>',
            disable_command_mode = true,
            disabled_filetypes = { 'c', 'cpp', 'python' } },
          ['>'] = { escape = true, close = false, pair = '<>',
            disable_command_mode = true,
            disabled_filetypes = { 'c', 'cpp', 'python' } },
          ["'"] = { escape = true, close = true, pair = "''" },
          -- in vim, " is used to comment
          ['"'] = { escape = true, close = true, pair = '""',
            disabled_filetypes = { 'vim' } },
        },
      })

      local function smart_quote_pair()
        local unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local current_line =
        vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ''

        -- notice that col is 0-based, string is 1-based
        local prev_char = col > 0 and current_line:sub(col, col) or ''
        -- local next_char = col < #current_line and
        -- current_line:sub(col + 1, col + 1) or ''
        -- if prev_char is a letter or "'", no auto-close
        if prev_char:match("[a-zA-Z0-9']") then
          return "'"
        else
          return "''<Left>"
        end
      end

      vim.keymap.set('i', "'", smart_quote_pair,
        { expr = true, noremap = true, silent = true })
    end,
  },
  {
    'ijimiji/tabout.nvim',
    event = 'InsertEnter',
  },
  {
    -- it does what he said, rainbow-delimiters(brackets)
    "HiPhish/rainbow-delimiters.nvim",
    event = { 'BufReadPost', 'BufNewFile', },
    config = function()
      require('rainbow-delimiters.setup').setup {
        highlight = {
          -- the order is bottom-up
          'RainbowDelimiterCyan',
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterRed',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
        },
      }
    end,
  },
}
