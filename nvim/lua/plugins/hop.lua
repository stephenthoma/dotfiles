return { -- Modern version of easymotion, jump around file
	"phaazon/hop.nvim",
	event = "BufReadPre",
	keys = {
		{ "<leader>gw", "<cmd>lua require'hop'.hint_words()<CR>", mode = { "n", "v" }, desc = "Go to word" },
		{ "<leader>gl", "<cmd>lua require'hop'.hint_lines()<CR>", mode = { "n", "v" }, desc = "Go to line" },
	},
	config = function()
		vim.cmd("hi HopNextKey guifg=#ff9900")
		vim.cmd("hi HopNextKey1 guifg=#ff9900")
		vim.cmd("hi HopNextKey2 guifg=#ff9900")
		require("hop").setup()
	end,
}
