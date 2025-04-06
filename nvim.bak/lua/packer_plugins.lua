--[[ Packer bootstrap and plugins installation --]]

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't get errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Problem to call Packer")
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Packer manage itself

    -- colorschemes and syntax highlighting with nvim-treesitter
    use("navarasu/onedark.nvim")
    use("folke/tokyonight.nvim")
    use("sainnhe/sonokai")
    use("rebelot/kanagawa.nvim")
    use("LunarVim/darkplus.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("ap/vim-css-color")
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    })
    -- use("nvim-treesitter/playground")
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use("p00f/nvim-ts-rainbow")

    -- LSP and completion related stuff
    use("nvim-lua/popup.nvim")
    use("neovim/nvim-lspconfig") -- Essential
    use("hrsh7th/nvim-cmp")      -- The autocompletion engine: below a bunch of completion sources
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lua")
    use("f3fora/cmp-spell")
    use("uga-rosa/cmp-dictionary")
    use("saadparwaiz1/cmp_luasnip")     -- Snippets completion
    use("L3MON4D3/LuaSnip")             -- Snippets engine
    use("rafamadriz/friendly-snippets") -- Lots of ready to use snippets
    use("ray-x/lsp_signature.nvim")     -- maintain popup with function signature
    use({ "williamboman/mason.nvim", requires = { "williamboman/mason-lspconfig.nvim" } })
    use("mfussenegger/nvim-lint")
    -- LSP auxiliar module for linters and formattters
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    })

    -- the initial screen when no file is provided
    use({
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    })

    -- History of undo
    use("mbbill/undotree")
    use("tpope/vim-fugitive")

    -- Telescope with native fzf extension
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- git integration
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Lines at bottom and top
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- File explorer
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
    })

    -- Terminal popup
    use("akinsho/toggleterm.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
