return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			scope = { enabled = true, highlight = { "DiagnosticInfo" } },
			whitespace = { remove_blankline_trail = false },
			indent = {
				char = "│",
				tab_char = "│",
			},
			exclude = {
				filetypes = {
					"help",
					"startify",
					"aerial",
					"alpha",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"neo-tree",
					"Trouble",
				},
				buftypes = {
					"nofile",
					"terminal",
				},
			},
		})
	end,
}
