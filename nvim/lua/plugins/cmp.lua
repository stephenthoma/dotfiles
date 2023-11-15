local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
        "saadparwaiz1/cmp_luasnip", -- required snip plugin
        "hrsh7th/cmp-nvim-lsp", -- LSP completions
        "hrsh7th/cmp-path", -- path completions
        "hrsh7th/cmp-buffer", -- buffer completions
        "hrsh7th/cmp-cmdline", -- completions while doing slash search
        "hrsh7th/cmp-nvim-lua", -- completions of neovim's lua api
        "L3MON4D3/LuaSnip",
	},
}

M.config = function()
	local cmp = require("cmp")
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources(
            {
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            },
            { { name = 'buffer' }, }
        )
    })
end

return M

-- local cmp = require("cmp")
-- local lspkind = require("lspkind")
--
-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- local lspkind_status_ok, lspkind = pcall(require, "lspkind")
-- if not snip_status_ok then return end
-- local border_opts = {
--   border = "single",
--   winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
-- }
--
-- local function has_words_before()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end
--
-- cmp.setup({
--   snippet = {
--     expand = function(args) luasnip.lsp_expand(args.body) end,
--   },
--   duplicates = {
--     nvim_lsp = 1,
--     luasnip = 1,
--     buffer = 1,
--     path = 1,
--   },
--   confirm_opts = {
--     behavior = cmp.ConfirmBehavior.Replace,
--     select = false,
--   },
--   window = {
--     completion = cmp.config.window.bordered(border_opts),
--     documentation = cmp.config.window.bordered(border_opts),
--   },
--   mapping = {
--   ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
--   ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
--   ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
--   ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
--   ["<C-y>"] = cmp.config.disable,
--   ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
--   ["<CR>"] = cmp.mapping.confirm { select = false },
--   ["<Tab>"] = cmp.mapping(function(fallback)
--     if cmp.visible() then
--       cmp.select_next_item()
--     elseif luasnip.expand_or_jumpable() then
--       luasnip.expand_or_jump()
--     elseif has_words_before() then
--       cmp.complete()
--     else
--       fallback()
--     end
--   end, { "i", "s" }),
--   ["<S-Tab>"] = cmp.mapping(function(fallback)
--     if cmp.visible() then
--       cmp.select_prev_item()
--     elseif luasnip.jumpable(-1) then
--       luasnip.jump(-1)
--     else
--       fallback()
--     end
--   end, { "i", "s" }),
-- },
--   completion = {
--     completeopt = "menu,menuone,noinsert",
--   },
--   sources = cmp.config.sources {
--     { name = "nvim_lsp", priority = 1000 },
--     { name = "luasnip", priority = 750 },
--     { name = "buffer", priority = 500 },
--     { name = "path", priority = 250 },
--   },
--   formatting = {
--     fields = { "kind", "abbr", "menu" },
--     format = lspkind.cmp_format({
--       with_text = true,
--       maxwidth = 50,
--       menu = {
--         buffer = "",
--         nvim_lsp = "",
--         spell = "",
--         look = "",
--       },
--     }),
--   },
-- })
--
-- cmp.setup.cmdline("/", {
--   sources = { { name = "buffer"} },
--   completion = {
--     completeopt = "menu,menuone,noselect",
--   },
-- })
--
-- cmp.setup.cmdline(':%s/', {
--   sources = {
--     { name = 'buffer' }
--   },
--   completion = {
--     completeopt = "menu,menuone,noselect",
--   },
-- })
