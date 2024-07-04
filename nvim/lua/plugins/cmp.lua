local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"saadparwaiz1/cmp_luasnip", -- required snip plugin
		"hrsh7th/cmp-nvim-lsp", -- LSP completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-cmdline", -- completions while doing slash search
		"hrsh7th/cmp-nvim-lua", -- completions of neovim's lua api
		"hrsh7th/cmp-nvim-lsp-signature-help", -- show function signature
		"L3MON4D3/LuaSnip",
	},
}

M.config = function()
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "luasnip", priority = 750 },
			{ name = "buffer", priority = 500 },
			{ name = "path", priority = 250 },
			{ name = "nvim_lsp_signature_help" },
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
		},
	})
	cmp.setup.cmdline("/", {
		sources = { { name = "buffer" } },
		mapping = cmp.mapping.preset.cmdline({
			["<C-n>"] = { c = cmp.mapping.select_next_item() },
			["<C-p>"] = { c = cmp.mapping.select_prev_item() },
		}),
		completion = {
			completeopt = "menu,menuone,noselect",
		},
	})

	cmp.setup.cmdline(":%s/", {
		sources = {
			{ name = "buffer" },
		},
		completion = {
			completeopt = "menu,menuone,noselect",
		},
	})
end

return M
