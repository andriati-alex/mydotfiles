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
keymaps('n', '<leader>h', '<cmd>tabprevious<CR>', opts)
keymaps('n', '<leader>l', '<cmd>tabnext<CR>', opts)
keymaps('n', '<leader>b', '<cmd>bnext<CR>', opts)
keymaps('n', '<leader>B', '<cmd>bprevious<CR>', opts)
-- Resize splits
keymaps("n", "<C-j>", ":resize +2<CR>", opts)
keymaps("n", "<C-k>", ":resize -2<CR>", opts)
keymaps("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymaps("n", "<C-l>", ":vertical resize +2<CR>", opts)
-- maintain selection when indenting in visual mode
keymaps('v', '<', '<gv', opts)
keymaps('v', '>', '>gv', opts)
-- restart undo break points for some characteres
keymaps('i', ',', ',<c-g>u', opts)
keymaps('i', '.', '.<c-g>u', opts)
keymaps('i', '[', '[<c-g>u', opts)
keymaps('i', ']', ']<c-g>u', opts)
keymaps('i', '(', '(<c-g>u', opts)
keymaps('i', ')', ')<c-g>u', opts)
keymaps('i', '?', '?<c-g>u', opts)
-- Do not override registers when pasting selected text
keymaps("v", "p", '"_dP', opts)
-- Fix some LSP delays
keymaps('i', '<C-c>', '<Esc>', opts)
