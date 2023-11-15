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
map('n', '<leader><CR>', 'zA')

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

-- LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true})
map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { silent = true})
map('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true})
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true})
map('n', '<leader>g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true})

-- Telescope
if is_git_repo() then
  map("n", "<leader>p", '<cmd>lua require("telescope.builtin").git_files()<CR>')
else
  map("n", "<leader>p", '<cmd>lua require("telescope.builtin").find_files()<CR>')
end
map("n", "-", '<cmd>lua require("telescope").extensions.file_browser.file_browser()<CR>')
map("n", "<leader>fR", '<cmd>lua require("telescope.builtin").registers()<CR>')
map("n", "<leader>fw", '<cmd>lua require("telescope.builtin").live_grep()<CR>')
map("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<CR>')
map("n", "<leader>gr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>')
--map("n", "<leader>h", '<cmd>lua require("telescope.builtin").git_bcommits()<CR>')
--map("n", "<leader>i", '<cmd>lua require("telescope.builtin").git_status()<CR>')

-- Gitsigns
map("n", "<leader>cb", '<cmd>Gitsigns blame_line<CR>')

-- Hop
map("n", "<leader>gw", "<cmd>lua require'hop'.hint_words()<CR>")
map("n", "<leader>gl", "<cmd>lua require'hop'.hint_lines()<CR>")
map("v", "<leader>gw", "<cmd>lua require'hop'.hint_words()<CR>")
map("v", "<leader>gl", "<cmd>lua require'hop'.hint_lines()<CR>")

-- Comment
map("n", "<leader>/", "<cmd> lua require('Comment.api').toggle.linewise.current()<CR>")
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

