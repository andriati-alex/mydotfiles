--[[ Config bottom status line --]]

-- Use a protected call so we don't get errors on first use
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("Problem to config Lualine. Is it installed?")
    return
end

lualine.setup({
    options = {
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = {
            {
                "branch",
                icon = "",
            },
            "diff",
            {
                "diagnostics",
                sections = { "error", "warn", "info", "hint" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
        },
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = { "progress", { "location", separator = { right = "" }, padding = 2 } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = { { "buffers", separator = { left = "", right = "" }, right_padding = 2 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { { "tabs", separator = { left = "", right = "" }, padding = 2 } },
    },
    extensions = {},
})
