return {
  {
    -- highlight, indent, fold function by syntax analyzing
    "nvim-treesitter/nvim-treesitter",
    lazy = false,           -- it doesn't support lazy-load
    priority = 1000,
    build = ":TSUpdate",
    config = function()
      vim.opt.autoindent = false
      vim.opt.cindent = false

      local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      treesitter.setup {
        modules = {},
        ignore_install = {},

        auto_install = true,
        sync_install = true,
        ensure_installed = {
          -- my main languages
          "c", "cpp", "python", "markdown",
          -- my config languages
          "lua", "vim",
        },
        highlight = {
          enable = true,
          -- disable highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = {
          enable = true,
          disable = {},
        },
        -- increase selection scope gradually
        incremental_selection = {
          enable = false,
        },
      }
    end
  },
  {
    -- show the context of the currently visible buffer contents
    -- show you which function you are looking at
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local tscontext = require('treesitter-context')
      tscontext.setup {
        enable = true,
        -- How many lines the window should span.
        max_lines = 0,              -- no limit
        -- Minimum editor window height to enable context.
        min_window_height = 0,      -- no limit
        line_numbers = true,
        -- Maximum number of lines to collapse for a single context line
        multiline_threshold = 20,   -- more than this will be folded
        -- Which context lines to discard if `max_lines` is exceeded.
        -- Choices: 'inner', 'outer'
        trim_scope = 'outer',
        -- Line used to calculate context. Choices: 'cursor', 'topline'
        mode = 'cursor',
        -- Separator between context and content.
        -- Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when
        -- there are at least 2 lines above cursorline.
        separator = nil,
        -- The Z-index of the context window
        zindex = 20,
        -- (fun(buf: integer): boolean) return false to disable attaching
        on_attach = nil,
      }
      vim.keymap.set("n", "[c", function()
        tscontext.go_to_context()
      end, { silent = true })
    end
  },
}
