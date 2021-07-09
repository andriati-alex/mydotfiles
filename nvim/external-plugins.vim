call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'ryanoasis/vim-devicons'
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'nvim-lua/completion-nvim'
    " Plug 'hrsh7th/nvim-compe'
    " Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'marko-cerovac/material.nvim'
    " Plug 'folke/tokyonight.nvim'
    Plug 'sainnhe/sonokai'
    Plug 'mhinz/vim-startify'
call plug#end()
