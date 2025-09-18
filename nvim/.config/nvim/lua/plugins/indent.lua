return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },     -- before reading/loading new files
  config = function()
    require('hlchunk').setup({
      -- it's slow, and sometimes it looks wired
      indent = {              -- vertical indent line, it's a little annoying for me now
        enable = true,
        -- style = { vim.api.nvim_get_hl(0, { name = "Whitespace" }) },
        use_treesitter = false,
        -- chars = { "│", "┊",},
        chars = { "┊" },
        style = {         -- Yeah, it's very clear, looks not too bad
          "#000000",      -- the first one will be ignored
          "#FF0000",      -- red
          "#FF7F00",      -- orange
          "#FFFF00",      -- yellow
          "#00FF00",      -- green
          "#00FFFF",      -- cyan
          "#0000FF",      -- blue
          "#8B00FF",      -- purple/violet
        },
        ahead_lines = 5,    -- check 5 lines ahead to determine
        delay = 100,        -- the bigger, the more fluent when scrolling
        filter_list = {     -- don't show the first level indent
          function(v)
            return v.level ~= 1
          end,
        },
      },
      blank = {               -- horizontal indent line
        enable = false,
      },
      line_num = {            -- highlight line number in current domain
        enable = true,
        use_treesitter = true,
      }
    })
  end,
}
