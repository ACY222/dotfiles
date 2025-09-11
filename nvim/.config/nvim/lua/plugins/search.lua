return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    config = function()
      require('flash').setup({
        -- f, F, t, T wiht labels
        modes = {
          char = {
            jump_labels = true
          }
        }
      })

      local word_flash = function() require('flash').jump() end
      -- x: visual mode, o: operator pending mode
      local mode = { 'n', 'x', 'o' }
      vim.keymap.set(mode, '<leader>w', word_flash, { noremap = true })
    end,
  },
}
