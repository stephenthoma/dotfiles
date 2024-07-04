local select_one_or_multi = function(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		require("telescope.actions").close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		require("telescope.actions").select_default(prompt_bufnr)
	end
end

return {
	"nvim-telescope/telescope.nvim",
	module = "telescope",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	keys = {
		{ "-", '<cmd>lua require("telescope").extensions.file_browser.file_browser()<CR>', desc = "Open file browser" },
		{ "<leader>,", '<cmd>lua require("telescope.builtin").buffers()<CR>', desc = "Switch Buffer" },
		-- find
		{ "<leader>p", '<cmd>lua require("telescope.builtin").git_files()<CR>', desc = "Find (git) files" },
		{ "<leader>P", '<cmd>lua require("telescope.builtin").find_files()<CR>', desc = "Find files" },
		-- search
		{ "<leader>sw", '<cmd>lua require("telescope.builtin").live_grep()<CR>', desc = "Grep files" },
		{ "<leader>sr", '<cmd>lua require("telescope.builtin").registers()<CR>', desc = "Registers" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },

		{ "<leader>gr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', desc = "Go to implementation" },
		{
			"<leader>sd",
			'<cmd>lua require("telescope.builtin").diagnostics({initial_mode="normal", bufnr=0})<CR>',
			desc = "Current buffer diagnostics",
		},
		{
			"<leader>ss",
			'<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>',
			desc = "Goto Symbol",
		},
	},
	config = function()
		-- Telescope Global remapping
		local action_state = require("telescope.actions.state")
		local actions = require("telescope.actions")
		local fb_actions = require("telescope._extensions.file_browser.actions")

		require("telescope").setup({
			defaults = {
				winblend = 20,
				sorting_strategy = "descending",
				layout_strategy = "flex",
				layout_config = {
					flex = {
						flip_columns = 140,
					},
					vertical = {
						preview_cutoff = 40,
						prompt_position = "bottom",
					},
					horizontal = {
						width = 0.9,
						height = 0.8,
					},
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<CR>"] = select_one_or_multi,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				file_browser = {
					path = "%:p:h", -- open browser to directory of active buffer
					theme = "ivy",
					initial_mode = "normal",
					mappings = {
						["n"] = {
							["-"] = fb_actions.goto_parent_dir,
							["<CR>"] = select_one_or_multi,
						},
						["i"] = {
							["<CR>"] = select_one_or_multi,
						},
					},
				},
			},
			pickers = {
				buffers = {
					sort_lastused = true,
					mappings = {
						i = {
							["<C-w>"] = "delete_buffer",
						},
						n = {
							["<C-w>"] = "delete_buffer",
						},
					},
				},
				-- Open file at specific line https://gitter.im/nvim-telescope/community?at=6113b874025d436054c468e6
				find_files = {
					on_input_filter_cb = function(prompt)
						local find_colon = string.find(prompt, ":")
						if find_colon then
							local ret = string.sub(prompt, 1, find_colon - 1)
							vim.schedule(function()
								local prompt_bufnr = vim.api.nvim_get_current_buf()
								local picker = action_state.get_current_picker(prompt_bufnr)
								local lnum = tonumber(prompt:sub(find_colon + 1))
								if type(lnum) == "number" then
									local win = picker.previewer.state.winid
									local bufnr = picker.previewer.state.bufnr
									local line_count = vim.api.nvim_buf_line_count(bufnr)
									vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
								end
							end)
							return { prompt = ret }
						end
					end,
					attach_mappings = function()
						actions.select_default:enhance({
							post = function()
								-- if we found something, go to line
								local prompt = action_state.get_current_line()
								local find_colon = string.find(prompt, ":")
								if find_colon then
									local lnum = tonumber(prompt:sub(find_colon + 1))
									vim.api.nvim_win_set_cursor(0, { lnum, 0 })
								end
							end,
						})
						return true
					end,
				},
			},
		})

		--require("telescope").load_extension("fzf")
		require("telescope").load_extension("file_browser")
	end,
}
