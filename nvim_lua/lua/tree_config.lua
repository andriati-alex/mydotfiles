--[[ An internal terminal for fast commands --]]
--
-- Use a protected call so we don't get errors on first use
local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("Problem to config nvim-tree. Is it installed?")
    return
end

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "",
        ignored = "◌",
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}

local tree_cb = require("nvim-tree.config").nvim_tree_callback

tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 40,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = true,
        number = false,
        relativenumber = false,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
                { key = "h", cb = tree_cb("close_node") },
                { key = "v", cb = tree_cb("vsplit") },
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})

vim.api.nvim_set_keymap("n", "<leader>E", "<cmd>NvimTreeToggle<CR>", { noremap = true })
