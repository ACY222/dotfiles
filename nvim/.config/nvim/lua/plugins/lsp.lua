return {
    {
        -- Portable package manager for Neovim
        -- Easy to install and manage LSP, DAP, linters and formatters
        "mason-org/mason.nvim",
        lazy = false,
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            { "mason-org/mason-lspconfig.nvim", build = ":MasonUpdate" },
            "saghen/blink.cmp",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            hint = { enable = true },
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                },
                -- use default settings
                ruff = {},
                pyright = {},
                marksman = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            inlayHints = { bindingHints = { enable = true } },
                            checkOnSave = { command = "clippy" },
                        },
                    },
                },
                tinymist = {
                    offset_encoding = "utf-8",
                    single_file_support = true,
                    root_dir = lspconfig.util.root_pattern("typstyle.toml", "typst.toml", ".git"),
                    settings = {
                        formatterMode = "typstyle",
                        exportPdf = "onType",
                        tinymist = {
                            inlayHints = {
                                enable = true,
                                typeHints = false,
                                parameterHints = false,
                            },
                        },
                    },
                },
                clangd = {
                    cmd = {
                        "/opt/homebrew/opt/llvm/bin/clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
            }

            require("mason").setup({ ui = { icons = { package_installed = "✓" } } })

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = true,

                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        lspconfig[server_name].setup(server)
                    end,
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local bufnr = args.buf

                    if not client then
                        return
                    end

                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end

                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end

                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action (Quick Fix)")
                    -- press again to focus on the documentation, then you can
                    -- move as normal, and use `q` to quit
                    map("n", "<leader>h", vim.lsp.buf.hover, "Hover Documentation")
                    map("n", "<leader>-", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, "Goto Previous Warning or Error")
                    map("n", "<leader>=", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, "Goto Next Warning or Error")
                    map("n", "<leader>ih", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, "Toggle Inlay Hints")
                end,
            })
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
            })
        end,
    },
}
