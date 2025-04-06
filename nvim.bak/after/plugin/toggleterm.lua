local Terminal = require("toggleterm.terminal").Terminal

function _LAZYGIT_TOGGLE()
	Terminal:new({ cmd = "lazygit", hidden = true }):toggle()
end

vim.keymap.set("n", "<leader>lg", "<cmd> lua _LAZYGIT_TOGGLE()<CR>", { noremap = true })
