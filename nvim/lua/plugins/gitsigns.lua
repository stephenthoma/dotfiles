return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
	end,
	keys = {
		{ "<leader>cb", "<cmd>Gitsigns blame_line<CR>", desc = "Show blame line" },
		{ "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset git hunk" },
	},
}
