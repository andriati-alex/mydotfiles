require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    --component_separators = { left = '', right = ''},
    --section_separators = { left = '', right = ''},
    -- component_separators = '|',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {"alpha", "dashboard", "NvimTree", "Outline"},
    always_divide_middle = true,
  },
  sections = {
    -- lualine_a = {'mode'},
    lualine_a = {
        { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
        {
            'branch',
            icon = '',
        },
        'diff',
        {
            'diagnostics',
            sections = {'error', 'warn', 'info', 'hint'},
            symbols = { error = " ", warn = " ", info = " ", hint = " "},
        }
    },
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'filetype', 'progress'},
    -- lualine_z = {'location'}
    lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      lualine_a = {'buffers'},
      lualine_b = {'branch'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
  },
  extensions = {}
}
