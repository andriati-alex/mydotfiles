--[[ An internal terminal for fast commands --]]
--
-- Use a protected call so we don't get errors on first use
local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("Problem to config nvim-tree. Is it installed?")
    return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback

tree.setup({
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    filters = {
        dotfiles = true,
        custom = { ".*__pycache__.*" },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 40,
        hide_root_folder = false,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
                { key = "h", cb = tree_cb("close_node") },
                { key = "v", cb = tree_cb("vsplit") },
                { key = "L", cb = tree_cb("cd") },
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})

vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<CR>")
