return {
  -- beautiful buffer line
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match('error') and " " or " "
        return ' ' .. icon .. count
      end,
      indicator = {
        -- style = 'icon' | 'underline' | 'none',
        style = 'none',
      },
      modified_icon = '+',
      numbers = function(opts)
        return string.format('%s', opts.raise(opts.id))
      end,
      -- icons
      show_buffer_icons = false,          -- disable filetype icons
      show_buffer_close_icons = false,
      show_close_icon = false,

      enforce_regular_tabs = true,
      show_duplicate_prefix = false,
      tab_size = 15,
      padding = 0,
      separator_style = 'thin',  -- see :h bufferline-styling
    }
  }
}
