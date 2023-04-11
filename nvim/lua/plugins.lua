vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Bootstrap the packer plugin if it isn't installed already
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

vim.api.nvim_command("packadd packer.nvim")

function get_setup(name)
  return string.format('require("setup/%s")', name)
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    use({ "goolord/alpha-nvim", config = get_setup("alpha") })
    use({ "nathom/filetype.nvim", config = get_setup("filetype") }) -- faster filetype detection
    use({ "lukas-reineke/indent-blankline.nvim", config = get_setup("indent-blankline") })
    use({ "NMAC427/guess-indent.nvim", config = function() require("guess-indent").setup() end })
    use({ "EdenEast/nightfox.nvim", config = get_setup("nightfox") }) -- colorscheme
    use({ "luukvbaal/stabilize.nvim", config = function() require("stabilize").setup() end }) -- prevent window contents from jumping around
    use({ "kyazdani42/nvim-web-devicons", config = function() require("nvim-web-devicons").setup() end })
    use({"nvim-lua/lsp-status.nvim", config = get_setup("lsp-status")}) -- put info from the LSP into status bar

    use({ "feline-nvim/feline.nvim", requires = {{"lewis6991/gitsigns.nvim"}}, config = get_setup("feline")}) -- statusline
    use({ "akinsho/bufferline.nvim", config = get_setup("bufferline") })
    use("christoomey/vim-tmux-navigator") -- move between vim and tmux seamlessly
    use("tpope/vim-surround") -- surround a word with something (ex: ysiw)

    use({ "neovim/nvim-lspconfig", config = get_setup("lsp") })
    use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" }, config = get_setup("null-ls") }) -- code formatters run as language servers
    use({ "onsails/lspkind-nvim", requires = { { "famiu/bufdelete.nvim" } } }) -- add pretty pictograms to LSP 
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "saadparwaiz1/cmp_luasnip" }, -- required snip plugin
        { "hrsh7th/cmp-nvim-lsp" }, -- LSP completions
        { "hrsh7th/cmp-path" }, -- path completions
        { "hrsh7th/cmp-buffer" }, -- buffer completions
        { "hrsh7th/cmp-cmdline" }, -- completions while doing slash search
        { "hrsh7th/cmp-nvim-lua" }, -- completions of neovim's lua api
      },
      config = get_setup("cmp"),
    })

    use({
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
      config = get_setup("telescope"),
    })
    use({ "nvim-telescope/telescope-file-browser.nvim" })

    use({ -- Use the LSP to browse symbols. Also supports renaming symbols
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
      setup = get_setup("outline"),
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        { "JoosepAlviste/nvim-ts-context-commentstring" }, -- make commenting code work correctly with embedded languages
        { "windwp/nvim-ts-autotag" } -- autoclose HTML tags
      },
      config = get_setup("treesitter"),
      run = ":TSUpdate",
    })

    use({ -- Modern version of easymotion, jump around file
      "phaazon/hop.nvim",
      event = "BufReadPre",
      config = get_setup("hop"),
    })

    use("MunifTanjim/nui.nvim") -- UI component library used by CodeGPT
    use("dpayne/CodeGPT.nvim") -- ChatGPT integration

    use({
      "kevinhwang91/nvim-ufo",
      event = "InsertEnter",
      requires = { "kevinhwang91/promise-async" },
      config = get_setup("nvim-ufo")
    })

    use({ -- Comment out code
      "numToStr/Comment.nvim",
      config = function() require('Comment').setup { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), } end
    })

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})

