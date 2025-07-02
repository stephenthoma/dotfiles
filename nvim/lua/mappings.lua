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

-- Keep cursor at beginning of line when repeatedly using J
map("n", "J", "mzJ`z")

-- Close current buffer with Leader + w
map("n", "<leader>w", ":bdelete<CR>")

--After searching, press escape to remove highlighted results
map("n", "<esc>", ":noh<CR><esc>", { silent = true })

-- Move highlighted text up/down
map("v", "J", ":M '>+1<CR>gv=gv")
map("v", "K", ":M '<-2<CR>gv=gv")
