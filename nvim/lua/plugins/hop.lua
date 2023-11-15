return { -- Modern version of easymotion, jump around file
    "phaazon/hop.nvim",
    event = "BufReadPre",
    keys = {
        {"<leader>gw", "<cmd>lua require'hop'.hint_words()<CR>", desc = "Go to word" },
        {"<leader>gl", "<cmd>lua require'hop'.hint_lines()<CR>", desc = "Go to line" },
    },
    config = function()
        vim.cmd("hi HopNextKey guifg=#ff9900")
        vim.cmd("hi HopNextKey1 guifg=#ff9900")
        vim.cmd("hi HopNextKey2 guifg=#ff9900")
        require("hop").setup()
    end,
}

