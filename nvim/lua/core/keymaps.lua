-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Buffer sequential movements
vim.keymap.set("n", "<leader>b", "<cmd>bnext<CR>", { desc = "Change to next [B]uffer" })
vim.keymap.set("n", "<leader>B", "<cmd>bprevious<CR>", { desc = "Change to previous [B]uffer" })

-- Equivalence Ctrl-C and ESC
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Ctrl-C equivalent to Escape" })
