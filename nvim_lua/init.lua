--[[ Set all basic stuff --]]

vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.confirm = true -- confirm to exit if there are unsave changes
vim.opt.hlsearch = false -- after hit enter stop highlighting
vim.opt.hidden = true -- let you change buffer without saving changes
vim.opt.wrap = false -- do not break long lines
vim.opt.cursorline = true -- highlight cursor line
vim.opt.fileencoding = "UTF-8"
vim.opt.number = true
vim.opt.relativenumber = true
-- All tab and indentation stuff
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
-- Finish tab and identation config
vim.opt.incsearch = true -- jump to result as you type
vim.opt.scrolloff = 8 -- minimum 8 lines ahead while scrolling
vim.opt.sidescrolloff = 8 -- minimum 8 columns scrolling
vim.opt.showmode = false
-- handle backup
vim.opt.backup = false
vim.opt.writebackup = false
-- mostly only due to completion
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.updatetime = 200

require("keybindings")
require("external_plugins")
require("colorscheme_config")
require("autocompletion_config")
require("treesitter_config")
require("telescope_config")
require("gitsigns_config")
require("lualine_config")
--require('bufferline_config')
require("tree_config")
require "toggleterm_config"

-- Starting page when invoked with no filename
require("alpha").setup(require("alpha.themes.startify").opts)
