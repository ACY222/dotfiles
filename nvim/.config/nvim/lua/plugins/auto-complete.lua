return {
    {
        -- Portable package manager for Neovim
        -- Easy install and manage LSP servers, DAP servers, linters and formatters
        'mason-org/mason.nvim',
        lazy = false,
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            { 'mason-org/mason-lspconfig.nvim', build = ':MasonUpdate' },
            'saghen/blink.cmp',
        },

        config = function()
            local lspconfig = require('lspconfig')
            local mason_lspconfig = require('mason-lspconfig')

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    -- 如果 LSP 支持 Inlay Hints，则开启
                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end
                end,
            })
            mason_lspconfig.setup({
                ensure_installed = {
                    'lua_ls',
                    'pylsp',
                    'clangd',
                    'marksman',
                    'rust_analyzer',
                },
                automatic_installation = true,
                automatic_enable = true,

                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({
                            on_attach = on_attach,
                        })
                    end,

                    ["clangd"] = function()
                        lspconfig.clangd.setup({
                            on_attach = on_attach,
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--clang-tidy",
                                "--header-insertion=iwyu",
                                "--completion-style=detailed",
                                "--function-arg-placeholders",
                                "--fallback-style=llvm",
                                "--inlay-hints=true",
                            },
                            init_options = {
                                usePlaceholders = true,
                                completeUnimported = true,
                                clangdFileStatus = true,
                            },
                            capabilities = {
                                offsetEncoding = "utf-8",
                            },
                        })
                    end,

                    ["rust_analyzer"] = function()
                        lspconfig.rust_analyzer.setup({
                            on_attach = on_attach,
                            settings = {
                                ["rust-analyzer"] = {
                                    inlayHints = {
                                        bindingHints = { enable = true },
                                        chainingHints = { enable = true },
                                        closingBraceHints = { enable = true, minLines = 25 },
                                        closureReturnTypeHints = { enable = "always" },
                                        lifetimeElisionHints = { enable = "always", useParameterNames = true },
                                        maxLength = 25,
                                        parameterHints = { enable = true },
                                        reborrowHints = { enable = "always" },
                                        renderColons = true,
                                        typeHints = {
                                            enable = true,
                                            hideClosureInitialization = false,
                                            hideNamedConstructor = false,
                                        },
                                    },
                                    checkOnSave = {
                                        command = "clippy",
                                    },
                                }
                            }
                        })
                    end,

                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            on_attach = on_attach,
                            settings = {
                                Lua = {
                                    hint = { enable = true },
                                    runtime = { version = 'LuaJIT' },
                                    diagnostics = {
                                        globals = { 'vim', 'require', 'opts' },
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false,
                                    },
                                    telemetry = { enable = false },
                                },
                            },
                        })
                    end,

                    -- ** Pylsp 配置 **
                    -- 注意：pylsp 原生不支持 inlay hints，通常需要 pyright 或 basedpyright
                    -- 这里保持你的原样，但加上 on_attach
                    ["pylsp"] = function()
                        lspconfig.pylsp.setup({
                            on_attach = on_attach,
                            settings = {
                                pylsp = {
                                    plugins = {
                                        pylint = { enabled = false },
                                        pyflakes = { enabled = false },
                                        mccabe = { enabled = false },
                                        flake8 = { enabled = true, maxLineLength = 120 },
                                        pylsp_mypy = { enabled = true, live_mode = false, strict = true },
                                    }
                                }
                            }
                        })
                    end,

                    -- ** Marksman 配置 **
                    ["marksman"] = function()
                        lspconfig.marksman.setup({
                            on_attach = on_attach,
                        })
                    end,
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

            vim.keymap.set('n', '<leader>ih', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = 'Toggle Inlay Hints' })
        end,
    },
    {
        'Saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
        },
        event = { 'BufReadPost', 'BufNewfile' },
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
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
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
