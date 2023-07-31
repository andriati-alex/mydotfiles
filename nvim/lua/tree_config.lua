local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("Problem to config nvim-tree. Is it installed?")
    return
end

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'O', '', { buffer = bufnr })
  vim.keymap.del('n', 'O', { buffer = bufnr })
  vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
  vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
  vim.keymap.set('n', 'D', '', { buffer = bufnr })
  vim.keymap.del('n', 'D', { buffer = bufnr })
  vim.keymap.set('n', 'E', '', { buffer = bufnr })
  vim.keymap.del('n', 'E', { buffer = bufnr })

  vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD dir'))

end

nvim_tree.setup({
    on_attach=my_on_attach,
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})

vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<CR>")
