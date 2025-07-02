return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- make commenting code work correctly with embedded languages
		"windwp/nvim-ts-autotag", -- autoclose HTML tags
	},
	keys = {
		{
			"<leader>/",
			"<Plug>(comment_toggle_linewise_visual)",
			mode = { "v" },
			desc = "Toggle line comment",
		},
		{
			"<leader>/",
			"<Plug>(comment_toggle_linewise_current)",
			mode = { "n" },
			desc = "Toggle line comment",
		},
	},
	lazy = false,
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}

