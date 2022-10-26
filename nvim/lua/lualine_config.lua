--[[ Config bottom status line --]]

-- Use a protected call so we don't get errors on first use
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("Problem to config Lualine. Is it installed?")
    return
end

-- cool function for progress
-- local progress = function()
--     local current_line = vim.fn.line(".")
--     local total_lines = vim.fn.line("$")
--     local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
--     local line_ratio = current_line / total_lines
--     local index = math.ceil(line_ratio * #chars)
--     return chars[index]
-- end

local colors = {
    blue = "#80a0ff",
    cyan = "#79dac8",
    black = "#080808",
    white = "#e6e6e6",
    red = "#ff5189",
    violet = "#d183e8",
    grey = "#303030",
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.cyan, bg = colors.black },
    },

    insert = { a = { fg = colors.black, bg = colors.violet } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    command = { a = { fg = colors.black, bg = "#ffd050" } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    },
}

lualine.setup({
    options = {
        icons_enabled = true,
        -- theme = bubbles_theme,
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left="|", right="|" },
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
