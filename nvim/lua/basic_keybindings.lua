--[[ Remaps not related to plugins --]]

vim.g.mapleader = " "
local keymaps = vim.keymap.set

--[[ HOW TO USE (RE)MAPS

CALLING:
    ``keymaps({mode}, {keymap}, {mapped to do}, {options})``

where {mode} is usually 'i' or 'n' for insert mode and normal mode respectively
the {keymap} is any combination of keys to produce the desired result
IMPORTANT: `C` corresponds to <Ctrl> and `M` to <Alt>
{mapped to do} is the command result of typing the {keymap}
{options} is any available additional options. Generally { noremap = true}

--]]

-- Buffers Navigation
keymaps("n", "<leader>b", vim.cmd.bnext)
keymaps("n", "<leader>B", vim.cmd.bprevious)

-- Resize splits
keymaps("n", "<M-j>", ":resize +2<CR>")
keymaps("n", "<M-k>", ":resize -2<CR>")
keymaps("n", "<M-h>", ":vertical resize -2<CR>")
keymaps("n", "<M-l>", ":vertical resize +2<CR>")

-- maintain selection when indenting in visual mode
keymaps("v", "<", "<gv")
keymaps("v", ">", ">gv")

-- restart undo break points for some characteres
keymaps("i", ",", ",<c-g>u")
keymaps("i", ".", ".<c-g>u")
keymaps("i", "[", "[<c-g>u")
keymaps("i", "]", "]<c-g>u")
keymaps("i", "(", "(<c-g>u")
keymaps("i", ")", ")<c-g>u")
keymaps("i", "?", "?<c-g>u")

-- Fix some LSP delays
keymaps("i", "<C-c>", "<Esc>")

-- Move selection all together
keymaps("v", "J", ":m '>+1<CR>gv=gv")
keymaps("v", "K", ":m '<-2<CR>gv=gv")

-- Freeze cursor when bringing live below to append in the end
keymaps("n", "J", "mzJ`z")

-- Maintain search terms in the middle
keymaps("n", "n", "nzzzv")
keymaps("n", "N", "Nzzzv")

-- When pasting with <leader>p keep the clipboard intact
keymaps("x", "<leader>p", "\"_dP")

-- Replace all occurances of word under the cursor
keymaps("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
