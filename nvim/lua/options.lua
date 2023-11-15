local opt = vim.opt -- to set options

-- Overall options
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.spelllang = { "en_gb" }
opt.mouse = "a" -- Enable mouse
opt.termguicolors = true -- Enable 24 bit colors
opt.hidden = true -- Enable background buffers
opt.clipboard = "unnamedplus" -- Connect with system clipboard
opt.completeopt = "menuone,noselect"
opt.formatoptions = "l"
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo" -- keep all undo files in the same place

-- Folding options
opt.foldenable = true -- Enable fold
opt.foldlevel = 99 -- Set high foldlevel for nvim-ufo
opt.foldlevelstart = 99 -- start with all code unfolded
opt.foldnestmax = 3
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Find and replace options
opt.hlsearch = true -- Highlight found searches
opt.incsearch = true -- Shows the match while typing
opt.ignorecase = true -- Ignore case in searches
opt.inccommand = "split" -- Get a preview of replacements
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") --  Highlight yanked text
opt.smartcase = true -- Do not ignore case when search string contains capitals

opt.scrolloff = 4 -- Minimum lines of content that can be on screen
opt.sidescrolloff = 8 -- Minimum columns of content that can be on screen
opt.fillchars = { eob = " " } -- Don't show `~` on blank lines after scrolling past end of buffer

-- Window decoration options
opt.cmdheight = 0 -- Hide command line unless needed
opt.laststatus = 3 -- Global status
opt.showmode = false -- Don't display what mode Vim is in (status line handles this)
opt.signcolumn = "yes:1" -- Always show signcolumns
opt.list = true -- Show some invisible characters
opt.listchars = { tab = " ", trail = "·" }

opt.backspace = { "indent", "eol", "start" } -- Backspace over everything in Normal mode
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.virtualedit = "block" -- Allow going past end of line in visual block mode
opt.linebreak = true -- Don't break words in two when text is being  wrapped to a new line
opt.wrap = false -- Don't do line wrapping by default
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

-- Indentation options
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indent
opt.tabstop = 4 -- Number of spaces tabs count as
opt.shiftwidth = 4 -- Number of spaces to use for indentation by default
vim.api.nvim_create_autocmd("FileType", { -- Only indent 2 spaces for JS etc
	pattern = "javascript,typescript,javascriptreact,typescriptreact",
	command = "setlocal shiftwidth=2 tabstop=2",
})
