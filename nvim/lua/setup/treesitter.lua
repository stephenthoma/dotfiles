require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = false },
})
-- Setup treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({ ensure_installed = "all", highlight = { enable = true } })
