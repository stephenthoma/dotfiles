-- Set symbols used in gutter
local signs = { Error = "● ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Set styling of auto complete window
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 100
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

return {
	-- Manages installation of command line formatters, LSP servers, etc
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"black",
				"css-lsp",
				"dockerfile-language-server",
				"eslint-lsp",
				"json-lsp",
				"lua-language-server",
				"prettier",
				"pyright",
				"shfmt",
				"stylua",
				"tailwindcss-language-server",
				"typescript-language-server",
				"usort",
				"yaml-language-server",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{ -- Utility for automated registration of LSPs installed by Mason w/  nvim-lspconfig
		"williamboman/mason-lspconfig",
		config = function(_)
			require("mason-lspconfig").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = false, -- Disable builtin virtual text diagnostic
				severity_sort = true,
			},
			-- add any global capabilities here
			capabilities = {},
			-- options for vim.lsp.buf.format
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
		},
		keys = {
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end,
				desc = "Goto Definition",
			},
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Go to next diagnostic" },
			{ "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show hover (func signature)" },
			{ "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open float" },
		},
		config = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
			require("mason-lspconfig").setup()
		end,
	},
}
