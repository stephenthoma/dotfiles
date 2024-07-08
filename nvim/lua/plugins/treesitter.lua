vim.g.skip_ts_context_commentstring_module = true
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring", -- make commenting code work correctly with embedded languages
			"windwp/nvim-ts-autotag", -- autoclose HTML tags
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				autotag = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = false },
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring", -- make commenting code work correctly with embedded languages
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
				languages = {
					typescript = "// %s",
				},
			})
		end,
	},
}
