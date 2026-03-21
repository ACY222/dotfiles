return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        cmd = { "ConformInfo" },
        config = function()
            require("conform").setup({

                formatters_by_ft = {
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                    typst = { "typstyle" },
                    python = { "ruff_organize_imports", "ruff_format" },
                    lua = { "stylua" },
                },

                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 2000,
                },

                formatters = {
                    -- C/C++
                    ["clang-format"] = {
                        prepend_args = {
                            "--style={" .. [[
                                BasedOnStyle: LLVM,
                                IndentCaseLabels: true,
                                IndentWidth: 4,
                                TabWidth: 4,
                                AccessModifierOffset: -4,
                                PointerAlignment: Right,
                                AlwaysBreakTemplateDeclarations: Yes,
                                BreakBeforeBraces: Attach
                            ]] .. "}",
                        },
                    },

                    ["stylua"] = {
                        prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                    },

                    ["ruff_format"] = {
                        args = function(_, _)
                            return {
                                "format",
                                "--line-length",
                                "120",
                                "--force-exclude",
                                "--stdin-filename",
                                "$FILENAME",
                                "-",
                            }
                        end,
                    },

                    ["ruff_organize_imports"] = {
                        command = "ruff",
                        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
                    },
                },
            })
        end,
    },

    {
        "zapling/mason-conform.nvim",
        dependencies = { "mason.nvim", "conform.nvim" },
        config = function()
            require("mason-conform").setup()
        end,
    },
}
