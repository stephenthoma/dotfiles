local opt = vim.opt -- to set options

opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.mouse = "a" -- Enable mouse
opt.backspace = { "indent", "eol", "start" }
opt.termguicolors = true -- Enable 24 bit colors
opt.hidden = true -- Enable background buffers
opt.clipboard = "unnamedplus" -- Connect with system clipboard
opt.completeopt = "menuone,noselect"
opt.formatoptions = "l"
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"

opt.foldenable = true -- Enable fold
opt.foldlevel = 99 -- Set high foldlevel for nvim-ufo
opt.foldlevelstart = 99 -- start with all code unfolded
opt.foldnestmax = 3

opt.hlsearch = true -- Highlight found searches
opt.incsearch = true -- Shows the match while typing
opt.ignorecase = true -- Ignore case in searches
opt.inccommand = "split" -- Get a preview of replacements
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") --  Highlight yanked text
opt.smartcase = true -- Do not ignore case when search string contains capitals
opt.spelllang = { "en_gb" }

opt.joinspaces = false -- No double spaces with join
opt.list = true -- Show some invisible characters
opt.listchars = { tab = " ", trail = "·" }

opt.scrolloff = 4 -- Lines of context to allow on screen
opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
opt.sidescrolloff = 8 -- Columns of context to include on screen
opt.cmdheight = 0 -- Hide command line unless needed
opt.laststatus = 3 -- Global status
opt.showmode = false -- Don't display mode
opt.signcolumn = "yes:1" -- Always show signcolumns
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.linebreak = true -- Stop words being broken on wrap
opt.wrap = false 
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.virtualedit = "block" -- Allow going past end of line in visual block mode

opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indent
opt.tabstop = 4 -- Number of spaces tabs count for
opt.shiftwidth = 4 -- Size of an indent
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript,typescript,javascriptreact,typescriptreact",
  command = "setlocal shiftwidth=2 tabstop=2"
})
