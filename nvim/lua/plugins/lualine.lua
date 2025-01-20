return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = 'VimEnter',
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      fg = "#C6F0FF",
      fg_dark = "#000000",
      blue_darker = "#112638",
      blue_lighter = "#224E71",
      green_lighter = "#206765",
      green_darker = "#123938",
      violet_lighter = "#E055EF",
      violet_darker = "#8A3493",
      yellow_lighter = "#CBB06B",
      yellow_darker = "#76663E",
      red_lighter = "#FF4A4A",
      red_darker = "#762222",
      inactive_bg = "#2C3043",
      semilightgray = "#767676"
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue_lighter, gui = "bold" },
        b = { bg = colors.blue_darker },
        c = { fg = colors.fg }
      },
      insert = {
        a = { bg = colors.green_lighter, gui = "bold" },
        b = { bg = colors.green_darker },
        c = { fg = colors.fg }
      },
      visual = {
        a = { bg = colors.violet_lighter, gui = "bold" },
        b = { bg = colors.violet_darker },
        c = { fg = colors.fg }
      },
      command = {
        a = { bg = colors.yellow_lighter, fg = colors.bg, gui = "bold" },
        b = { bg = colors.yellow_darker },
        c = { fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red_lighter, gui = "bold" },
        b = { bg = colors.red_darker },
        c = { fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "filetype" },
        },
      },
    })
  end,
}
