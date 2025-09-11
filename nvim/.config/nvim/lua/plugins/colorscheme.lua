return {
  -- add dracula
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  config = function ()
    require('dracula').setup({
      transparent_bg = true,
      italic_comment = true,
      lualine_bg_color = "#44475a",
    })
    vim.cmd([[colorscheme dracula]])
  end,
}
-- return {
--   -- colorscheme
--   'folke/tokyonight.nvim',
--   lazy = false,           -- load it during startup
--   priority = 1000,        -- load this before all other plugins
--   config = function()
--     require('tokyonight').setup({
--       style = 'storm',
--       transparent = true,
--       terminal_colors = true,
--       styles = {
--         comment = { bold = true },
--         keywords = { italic = true },
--         sidebars = 'transparent',
--         floats = 'transparent',
--       },
--     })
--     -- load the colorscheme here
--     vim.cmd([[colorscheme tokyonight-storm]])
--   end,
-- }
