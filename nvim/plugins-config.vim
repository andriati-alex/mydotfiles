" -----------------------------------------------------------------------------
" LIGHTLINE CONFIG

let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGitbranch',
      \   'filename': 'LightlineFilename',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'cocstatus': 'coc#status'
      \ },
      \ 'subseparator' : {'left': '', 'right': ''},
      \ 'separator' : {'left': '', 'right': ''}
      \ }

" the cocstatus function is taken from :h coc-status-lightline

" Check :h g:lightline.colorscheme to see all colorschemes
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

" -----------------------------------------------------------------------------
" TELESCOPE

lua << EOF
require('telescope').setup{
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case"         -- or "ignore_case" or "respect_case"
        }
    }
}
require('telescope').load_extension('fzf')
EOF

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>

" -----------------------------------------------------------------------------

" For pycodestyle see https://pycodestyle.pycqa.org/en/latest/index.html
" specifically to consult some of the error codes

"lua << EOF
"require'lspconfig'.pylsp.setup{
"    on_attach = require'completion'.on_attach,
"    settings = {
"        pylsp = {
"            plugins = {
"                mccabe = {
"                    enabled = false
"                },
"                pycodestyle = {
"                    enabled = true,
"                    ignore = {"W605"}
"                },
"            },
"            configurationSources = {'pycodestyle', 'pyflakes'},
"        },
"    },
"}
"EOF
"
"" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"let g:completion_matching_strategy_list = ['exact', 'substring']
"let g:completion_matching_smart_case = 1
"let g:completion_trigger_on_delete = 1
"let g:completion_trigger_keyword_length = 2
"let g:completion_enable_auto_paren = 1
"let g:completion_abbr_length = 60
"let g:completion_menu_length = 80

" -----------------------------------------------------------------------------
" Coc-vim general configuration

set updatetime=300

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

" highlight CocHighlightText cterm=underline ctermfg=205

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" update lighline whenever some error is detected
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" -----------------------------------------------------------------------------
" COLORSCHEME
"lua << EOF
"vim.g.material_style = 'darker'
"vim.g.material_contrast = true
"vim.g.material_borders = true
"vim.g.material_disable_background = false
"--vim.g.material_custom_colors = { black = "#000000", bg = "#0F111A" }
"require('material').set()
"EOF
"-- Example config in Lua
"lua << EOF
"vim.g.tokyonight_style = "night"
"vim.g.tokyonight_italic_functions = true
"vim.g.tokyonight_italic_comments = false
"
"-- Change the "hint" color to the "orange" color, and make the "error" color bright red
"vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
"
"-- Load the colorscheme
"vim.cmd[[colorscheme tokyonight]]
"EOF


if has('termguicolors')
  set termguicolors
endif

let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_current_word = 'underline'
let g:sonokai_diagnostic_line_highlight = 0
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_sign_column_background = 'none'
let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1
let g:sonokai_menu_selection_background = 'green'


colorscheme sonokai
