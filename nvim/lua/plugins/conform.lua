return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "usort", "black" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				sh = { "shfmt" },
			},
			format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },

			formatters = {
				black = { prepend_args = { "--line-length", "100", "--fast" } },
			},
		})
	end,
}
