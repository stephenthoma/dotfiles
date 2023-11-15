-- Nightfox config
local nightfox = require("nightfox")


function getFoxType()
    -- Hack to pull the desired nightfox type out of the vimrc_background
    -- file written by alacritty-colorscheme
    bg_path = os.getenv("HOME") .. "/.vimrc_background"
    if vim.fn.filereadable(bg_path) then
        local f = io.open(bg_path, "r")
        local str = f:read("*all")
        if (string.find(str, "dayfox")) then return "dayfox" else return "nightfox" end
        io.close()
    end
    return "dayfox" -- default to dayfox if the file isn't present
end

nightfox.setup({
  alt_nc = false,
  options = {
  styles = {
    comments = "italic",
    keywords = "bold",
    functions = "italic,bold",
  },
  inverse = {
    visual = false,
    search = false,
    match_paren = false,
  },
  }
})
vim.cmd("colorscheme " .. getFoxType())


-- Good info on overriding colors: https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
-- Note had to add the SpecialKey to keep highlight on yank working alongside the CursorLine override
vim.api.nvim_exec(
  [[
function! MyHighlights() abort
    highlight CursorLine guifg=NONE guibg=#353A54
    highlight CmpItemAbbr guifg=#9FA4B6
    highlight SpecialKey guibg=NONE
    highlight CmpItemKind guifg=#8289A0
    highlight CmpItemMenu guifg=#8289A0
    highlight PmenuSel guibg=#73daca guifg=#111111
    highlight Pmenu guibg=#2E3248
    highlight GitSignsAddNr guifg=#26A07A
    highlight GitSignsDeleteNr guifg=#E87D7D
    highlight GitSignsChangeNr guifg=#AD991F
    endfunction
augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END]],
  true
)
