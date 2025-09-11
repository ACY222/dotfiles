return {
  'folke/ts-comments.nvim',
  opts = {},
  event = 'BufRead',         -- start after entering vim
  enabled = vim.fn.has('nvim-0.10.0') == 1,       -- check if current version >= 0.10.0
}
