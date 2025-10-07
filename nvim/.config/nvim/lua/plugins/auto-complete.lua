return {
  {
    -- Portable package manager for Neovim
    -- Easy install and manage LSP servers, DAP servers, linters and formatters
    'mason-org/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },

  {
    -- mason-lspconfig bridges mason.nvim with the lspconfig plugin
    -- making it easier to use both plugins together
    -- automatically install and enable installed servers
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'mason-org/mason.nvim', build = ':MasonUpdate', }
    },
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        automatic_enable = true,
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('mason').setup({})
      require('mason-lspconfig').setup({
        -- see :h lspconfig-all
        -- it takes me a long time to install these lsps
        ensure_installed = {
          'lua_ls',               -- lua
          'pylsp',                -- python
          'clangd',               -- c/cpp
          'marksman',             -- markdown
          -- 'rust-analyzer',        -- rust
        },
        automatic_enable = true,
        automatic_installation = true,
      })
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = { 'vim', 'require', 'opts' },
              disable = {
                'trailing-space',   -- empty line and space in the end
                'whitespace',
              },
            },
            -- enable lsp to understand vimscript's configuration files
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            -- disable telemetry function, which will collect your data
            telemetry = { enable = false },
          },
        },
      })

      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              -- disable unused plugins
              pylint = { enabled = false },
              pyflakes = { enabled = false },
              mccabe = { enabled = false },
              -- code check
              flake8 = {
                enabled = true,
                maxLineLength = 120
              },
              -- auto completion
              jedi_completion = {
                fuzzy = false,
                include_params = false
              },
              -- type check
              pylsp_mypy = {
                enabled = true,
                live_mode = false,  -- close live mode for better performance
                strict = true
              }
            }
          }
        }
      })

      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--pch-storage=memory",
        },
        filetypes = { "c", "cpp" },
        root_dir = lspconfig.util.root_pattern(
          ".clangd", ".clang-tidy", ".clang-format",
          "compile_commands.json", "compile_flags.txt",
          "configure.ac", ".git"
        ),
        capabilities = {
          offsetEncoding = "utf-8"
        }
      })

      lspconfig.marksman.setup({
        settings = {
          marksman = {
            -- check root directory
            rootMarkers = { "README.md", ".git/" },
            -- symbols settings
            symbols = {
              autoClosingTags = true,
              autoLinkReferences = true
            },
            -- link check
            links = {
              check = true,
              resolveRelative = true
            }
          }
        }
      })

      -- display hover information about the symbol under the cursor
      vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover,
        { desc = 'display hover information' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        { desc = 'goto definition' })
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition,
        { desc = 'goto type definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references,
        { desc = 'goto references' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        { desc = 'rename variables' })
      -- pop-up window to show fix suggestions
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        { desc = 'display fix suggestions' })
      -- go to previous/next warning or error
      vim.keymap.set('n', '<leader>-', vim.diagnostic.goto_prev,
        { desc = 'goto previous warning or error' })
      vim.keymap.set('n', '<leader>=', vim.diagnostic.goto_next,
        { desc = 'goto next warning or error' })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        }
      })
    end
  },

  {
    'Saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'xzbdmw/colorful-menu.nvim',    -- menu highlight, and more information
    },

    event = { 'BufReadPost', 'BufNewfile' },
    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      completion = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzy match on the text before & after the cursor
        keyword = { range = 'full' },
        -- select automatically, because I use <C-y> to insert, and don't auto insert
        list = { selection = {  preselect = true, auto_insert = false } },
        documentation =  {    -- no documentation showed
          auto_show = true,
          auto_show_delay_ms = 500,
          -- enable this if high CPU usage
          -- treesitter_highlighting = false,
        },
        -- use noice's cmdline menu instead
        -- cmdline = {
        --   enbaled = false,
        -- },
        menu = {
          auto_show = true,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },

      keymap = {
        preset = 'none',    -- disable the default keymap
        -- use <C-n>/<C-p> to select suggestions
        ['<C-N>'] = { 'select_next', 'fallback' },
        ['<C-P>'] = { 'select_prev', 'fallback' },
        ['<C-Y>'] = { 'accept', 'fallback' },
        -- use <Tab>/<S-Tab> to edit snippets to avoid confliction
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },

      -- use noice's cmdline menu
      cmdline = {
        enabled = false,
      },

      appearance = { nerd_font_variant = 'mono' },
    },
  },
}
