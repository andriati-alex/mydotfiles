syntax on

set encoding=UTF-8
set nocompatible

let mapleader=" "
" highlight Normal ctermbg=233

" line numbering and colors
" set nu
set relativenumber
hi CursorLineNr cterm=Bold ctermfg=200 ctermbg=234
hi LineNr ctermfg=238

" Colors for pop-up menus. Use :hi so see more info
hi Pmenu ctermbg=0 ctermfg=15
hi PmenuSel cterm=Bold ctermbg=0 ctermfg=205

" highlight the current line of the cursor
set cursorline
highlight Cursorline cterm=bold ctermbg=234

" dynamic change cursor for | when insert mode is active
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" minimum lines until the end
set scrolloff=10

" highlight patterns found before hit enter
set incsearch

" display vim option for a command pressing tab. try :help <Tab>
set wildmenu

" When trying to quit without saving
set confirm

" header files with .h extension forced to be
" interpreted as c filetype instead of c++
let g:c_syntax_for_h = 1

" wrap word at the end of the line
set wrap

" Alt+Arrows to navigate through the tabs
" The default key <CR+PgUp> is the same of terminal tabs
nnoremap <silent> <leader>h :tabprevious<CR>
nnoremap <silent> <leader>l :tabnext<CR>

" All tab stuff
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins. See https://github.com/junegunn/vim-plug
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot'             " language support
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'            " To display git branch in status line
Plug 'dense-analysis/ale'               " linters and fixers
Plug 'mattn/emmet-vim'                  " auto completion for html/css
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'git@github.com:Valloric/YouCompleteMe.git' " Coc alternative

call plug#end()

" Fuzzy-Finder configuration
let g:fzf_layout = { 'up': '40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
nnoremap <silent> <C-f> :FZF<cr>

" ALE configuration. For more info type :ALEInfo in a openned file
" Code identation convention (black) in python https://github.com/psf/black
" gcc compilation errors and warnings

let g:ale_linters_explicit = 1
let g:ale_lint_delay = 0
let g:ale_fixers = {
      \ '*' : ['trim_whitespace', 'remove_trailing_lines'],
      \ 'python' : ['black']
      \ }
let g:ale_linters = {
      \ 'python': ['pyflakes'],
      \ 'c': ['gcc']
      \ }
let g:ale_c_cc_executable = 'gcc'
let g:ale_c_cc_options = '-I./include -lm -fopenmp -Wall'
let g:ale_python_black_options = '--line-length 79'
let g:ale_fix_on_save = 1

" ALE error navigation
nnoremap <silent> <C-j> :ALENext<cr>
nnoremap <silent> <C-k> :ALEPrevious<cr>

" nerdtree toggle
nnoremap <leader>o :NERDTreeToggle<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" nerdtree-git-plugin
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '',
    \ "Unknown"   : "?"
    \ }

" Configuring the itchyny/lightline.vim
" laststatus just highlight the information bar
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGitbranch',
      \   'filename': 'LightlineFilename',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ 'subseparator' : {'left': '', 'right': ''},
      \ 'separator' : {'left': '', 'right': ''}
      \ }

" type :h g:lightline.colorscheme to see all colorschemes
" molokai ayu_light powerline powerlineish deus 16color

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" To insert branch symbol https://github.com/itchyny/lightline.vim/issues/271
function! LightlineGitbranch()
  let branch = gitbranch#name()
  return branch !=# '' ? ' '.branch : ''
endfunction

" To display nice icon according to file type
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" emmet configuration just for html and css
let g:user_emmet_install_global = 0
autocmd FileType html,htmldjango,css EmmetInstall

" Coc-vim general configuration

set updatetime=100

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use tab to navigation in completion suggestion pop-up window
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

highlight CocHighlightText cterm=underline ctermfg=205
