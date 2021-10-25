let g:mapleader = "\<Space>"

syntax on
set confirm         " confirm to exit if there are unsave changes
set nowrap          " do not break long lines
set cursorline      " highlight cursor line
set nohlsearch      " after hit enter stop highlighting
set hidden          " let you change buffer without saving changes
set encoding=UTF-8
set number
set relativenumber
" All tab and indentation stuff
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
" -----------
set incsearch       " jump to result as you type
set scrolloff=8     " minimum 8 lines ahead while scrolling
set completeopt=menuone,noinsert,noselect
set noshowmode

" hardcoded highlight colors
" hi LineNr ctermfg=239
" hi Cursorline cterm=bold ctermbg=234
" hi CursorLineNr cterm=Bold ctermfg=200 ctermbg=234

" walk through tabs
nnoremap <silent> <leader>h :tabprevious<CR>
nnoremap <silent> <leader>l :tabnext<CR>
nnoremap <silent> <leader>t :tab ball<CR>
" walk through buffers
nnoremap <silent> <leader>b :bnext<CR>
" Progressive (un)indent selection
vnoremap < <gv
vnoremap > >gv
" run black
" see https://github.com/psf/black/issues/1293
" au FileType python nnoremap <buffer> <leader>; :silent !black -l 79 %<CR><CR>

" header files with .h extension forced to be
" interpreted as c filetype instead of c++
let g:c_syntax_for_h = 1
