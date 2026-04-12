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
                                IndentWidth: 4,
                                TabWidth: 4,
                                UseTab: Never,
                                ColumnLimit: 80,
                                AccessModifierOffset: -4,
                                IndentCaseLabels: true,

                                BreakBeforeBinaryOperators: NonAssignment,
                                BreakBeforeBraces: Attach,
                                BreakBeforeCloseBracketBracedList: true,
                                BreakBeforeCloseBracketFunction: true,
                                BreakBeforeCloseBracketIf: true,
                                BreakBeforeCloseBracketLoop: true,
                                BreakBeforeCloseBracketSwitch: true,

                                AlignAfterOpenBracket: Align,
                                AlignConsecutiveAssignments: false,
                                AlignConsecutiveDeclarations: false,
                                AlignConsecutiveShortCaseStatements: {
                                    Enabled: true,
                                    AcrossEmptyLines: true,
                                    AcrossComments: true,
                                    AlignCaseColons: false
                                },
                                AlignOperands: Align,
                                AlignTrailingComments: false,

                                PointerAlignment: Right,
                                ReferenceAlignment: Left,

                                AllowShortCaseLabelsOnASingleLine: true,
                                AllowShortIfStatementsOnASingleLine: AllIfsAndElse,
                                AllowShortFunctionsOnASingleLine: InlineOnly,
                                AllowShortBlocksOnASingleLine: Always,
                                AlwaysBreakTemplateDeclarations: Yes,

                                SpaceBeforeCpp11BracedList: true,
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
