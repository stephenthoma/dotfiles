LSP_SERVERS = {
	-- python
	"pyright",
	-- web dev
	"cssls",
	"eslint",
	"prettier",
	"tailwindcss",
	"tsserver",
	-- general
	"jsonls",
	"dockerls",
	"lua_ls",
	"luaformatter",
	"yamlls",
}

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
			},
			-- add any global capabilities here
			capabilities = {},
			-- Automatically formAt on save
			autoformat = true,
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
			{ "<leader>k", "vim.lsp.buf.hover", desc = "Hover" },
			{ "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open float" },
		},
		config = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
			require("plugins.lsp.format").setup(opts)

			local servers = LSP_SERVERS
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")

			if have_mason then
				mlsp.setup({ ensure_installed = LSP_SERVERS })
				mlsp.setup_handlers({ setup })
			end
		end,
	},

	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.lua_format,
					nls.builtins.formatting.usort,
					nls.builtins.formatting.black.with({
						extra_args = { "--line-length", "100" },
					}),
					nls.builtins.formatting.prettier,
				},
			}
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
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
}
