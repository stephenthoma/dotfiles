-- Feline statusline definition.
--
-- Note: This statusline does not define any colors. Instead the statusline is
-- built on custom highlight groups that I define. The colors for these
-- highlight groups are pulled from the current colorscheme applied. Check the
-- file: `lua/eden/modules/ui/colors.lua` to see how they are defined.

local u = require("feline-util")
local fmt = string.format
-- -- "┃", "█", "", "", "", "", "", "", "●"

local function vi_mode_hl()
	return u.vi.colors[vim.fn.mode()] or "FlnViBlack"
end

local c = {
	vimode = {
		provider = function()
			local mode = vim.fn.mode()
			local recording = vim.fn.reg_recording()
			local mode_text = u.vi.text[mode]

			if recording ~= "" then
				return string.format(" REC @%s ", recording)
			else
				return string.format(" %s ", mode_text)
			end
		end,
		hl = vi_mode_hl,
	},
	gitbranch = {
		provider = "git_branch",
		icon = "  ",
		hl = "FlnGitBranch",
		right_sep = { str = " ", hl = "FlnGitBranch" },
		enabled = function()
			return vim.b.gitsigns_status_dict ~= nil
		end,
	},
	fileinfo = {
		provider = { name = "file_info", opts = { type = "relative" } },
		type = "unique",
		hl = "FlnAlt",
		left_sep = { str = "  ", hl = "FlnAltSep" },
		right_sep = { str = " ", hl = "FlnAltSep" },
	},
	file_type = {
		provider = function()
			return fmt(" %s ", vim.bo.filetype:upper())
		end,
		hl = "FlnAlt",
	},
	cur_position = {
		provider = function()
			-- TODO: What about 4+ digit line numbers?
			return fmt(" %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
		end,
		hl = vi_mode_hl,
	},
	cur_percent = {
		provider = function()
			return " " .. require("feline.providers.cursor").line_percentage() .. "  "
		end,
		hl = vi_mode_hl,
		left_sep = { str = u.icons.page, hl = vi_mode_hl },
	},
	default = { -- needed to pass the parent StatusLine hl group to right hand side
		provider = "",
		hl = "StatusLine",
	},

	in_fileinfo = {
		provider = "file_info",
		hl = "StatusLine",
	},
	in_position = {
		provider = "position",
		hl = "StatusLine",
	},
}

local active = {
	{ -- left
		c.vimode,
		c.gitbranch,
		c.fileinfo,
		c.default, -- must be last
	},
	{ -- right
		c.file_type,
		c.cur_position,
		c.cur_percent,
	},
}

local inactive = {
	{ c.in_fileinfo }, -- left
	{ c.in_position }, -- right
}

return {
	"feline-nvim/feline.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.o.termguicolors = true
		require("feline").setup({
			components = { active = active, inactive = inactive },
			highlight_reset_triggers = {},
			force_inactive = {
				filetypes = {
					"NvimTree",
					"packer",
					"dap-repl",
					"dapui_scopes",
					"dapui_stacks",
					"dapui_watches",
					"dapui_repl",
					"LspTrouble",
					"qf",
					"help",
				},
				buftypes = { "terminal" },
				bufnames = {},
			},
			disable = {
				filetypes = {
					"dashboard",
					"startify",
				},
			},
		})
	end,
}
