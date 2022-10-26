--[[ Remaps not related to plugins --]]

local keymaps = vim.api.nvim_set_keymap
local opts = { noremap = true }

--[[ HOW TO USE (RE)MAPS

CALLING:
    ``keymaps({mode}, {keymap}, {mapped to do}, {options})``

where {mode} is usually 'i' or 'n' for insert mode and normal mode respectively
the {keymap} is any combination of keys to produce the desired result
{mapped to do} is the command result of typing the {keymap}
{options} is any available additional options. Generally {options} = { noremap = true}

--]]

-- Buffers and tabs Navigation
keymaps("n", "<leader>h", "<cmd>tabprevious<CR>", opts)
keymaps("n", "<leader>l", "<cmd>tabnext<CR>", opts)
keymaps("n", "<leader>b", "<cmd>bnext<CR>", opts)
keymaps("n", "<leader>B", "<cmd>bprevious<CR>", opts)
-- Resize splits
keymaps("n", "<M-j>", ":resize +2<CR>", opts)
keymaps("n", "<M-k>", ":resize -2<CR>", opts)
keymaps("n", "<M-h>", ":vertical resize -2<CR>", opts)
keymaps("n", "<M-l>", ":vertical resize +2<CR>", opts)
-- maintain selection when indenting in visual mode
keymaps("v", "<", "<gv", opts)
keymaps("v", ">", ">gv", opts)
-- restart undo break points for some characteres
keymaps("i", ",", ",<c-g>u", opts)
keymaps("i", ".", ".<c-g>u", opts)
keymaps("i", "[", "[<c-g>u", opts)
keymaps("i", "]", "]<c-g>u", opts)
keymaps("i", "(", "(<c-g>u", opts)
keymaps("i", ")", ")<c-g>u", opts)
keymaps("i", "?", "?<c-g>u", opts)
-- Do not override registers when pasting selected text
keymaps("v", "p", '"_dP', opts)
-- Fix some LSP delays
keymaps("i", "<C-c>", "<Esc>", opts)

--[[ Keymaps in plugins configuration

LSP
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>;', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

Telescope/Find
    vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd> lua require('telescope.builtin').find_files()<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd> lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd> lua require('telescope.builtin').buffers()<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd> lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
--]]
