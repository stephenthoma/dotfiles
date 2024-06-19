local function is_git_repo()
	local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree")

	return vim.v.shell_error == 0
end

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
vim.g.mapleader = " "

-- Fold
map("n", "<leader><CR>", "zA")

-- jj to exit Insert mode
map("i", "jj", "<Esc>")

-- Shift-Q to run last macro
map("n", "Q", "@@", { silent = true })

-- Make visual yanks place the cursor back where started
map("v", "y", "ygv<Esc>")

-- Tab to switch buffers in Normal mode
map("n", "<Tab>", ":BufferLineCycleNext<CR>")
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
-- Leader + Tab to rearrange buffers shown in buffer line
map("n", "<leader><Tab>", ":BufferLineMoveNext<CR>")
map("n", "<leader><S-Tab>", ":BufferLineMovePrev<CR>")
-- Close current buffer with Leader + w
map("n", "<leader>w", ":bdelete<CR>")

--After searching, press escape to remove highlighted results
map("n", "<esc>", ":noh<CR><esc>", { silent = true })

-------- Plugin mappings --------
-- Mapping Conventions
-- - Commands that take you something prefixed with 'g' for 'go'
-- - Commands that help you find something prefixed with 'f' for 'find'

-- Undo tree
-- map("n", "<F5>", "UndoTreeToggle<CR>", { silent = true })

-- Hop
map("v", "<leader>gw", "<cmd>lua require'hop'.hint_words()<CR>")
map("v", "<leader>gl", "<cmd>lua require'hop'.hint_lines()<CR>")

-- Comment
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
