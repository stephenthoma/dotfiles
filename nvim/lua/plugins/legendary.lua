return {
	"mrjones2014/legendary.nvim",
	priority = 10000,
	lazy = false,
	dependencies = {
		"stevearc/dressing.nvim",
	},
	keys = {
		{ "<leader>?", "<cmd>Legendary<cr>", desc = "Open Legendary" },
	},
	config = function()
		require("legendary").setup({
			include_builtin = false,
			include_legendary_cmds = false,
			extensions = {
				lazy_nvim = { auto_register = true },
			},
			keymaps = {
				{ "<leader><CR>", "zA", desc = "Recursively open/close current fold" },
				{ "zM", "zM", desc = "Close all folds" },
				{ "zR", "zR", desc = "Open all folds" },
				{ "<leader><Tab>", ":BufferLineMoveNext<CR>", desc = "Move buffer forwards in bufferline" },
				{ "<leader><S-Tab>", ":BufferLineMovePrev<CR>", desc = "Move buffer back in bufferline" },
				{ "<leader>w", ":bdelete<CR>", desc = "Close current buffer" },
			},
		})
	end,
}
