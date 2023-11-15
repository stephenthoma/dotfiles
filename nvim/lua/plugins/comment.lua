return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    keys = {
        {"<leader>/", "<cmd> lua require('Comment.api').toggle.linewise.current()<CR>", desc = "Toggle line comment" },
    },
    lazy = false,
    config = function()
	    require('Comment').setup {
		    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
	    }
    end
}

