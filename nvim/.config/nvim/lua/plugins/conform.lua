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
					markdown = { "prettier" },
					typst = { "typstyle" },
					python = { "isort", "black" },
					lua = { "stylua" },
				},

				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},

				formatters = {
					["clang-format"] = {
						prepend_args = {
							"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4}",
						},
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
