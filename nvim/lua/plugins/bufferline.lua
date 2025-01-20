return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      indicator = {
          style = "icon"
      },
      separator_style = "slant",
      show_close_icon = false,
      show_buffer_close_icons = false,
    },
  },
}
