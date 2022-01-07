--[[ The colorschme --]]

-- Some that are really worth to try out
-- sonokai
-- kanagawa
-- darkplus

--vim.cmd [[let g:sonokai_style = 'shusia' ]]
--vim.cmd [[let g:sonokai_transparent_background = 1 ]]
--vim.cmd [[let g:sonokai_enable_italic = 1 ]]
--vim.cmd [[let g:sonokai_diagnostic_virtual_text = 'colored' ]]
--vim.cmd [[let g:sonokai_diagnostic_text_highlight = 1 ]]
--vim.cmd [[let g:sonokai_current_word = 'underline' ]]

local overrides_fields = {
    TSOperator = { style = "bold" },
}

-- Default options:
require("kanagawa").setup({
    undercurl = true, -- enable undercurls
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = true, -- do not set background color
    colors = {},
    overrides = overrides_fields,
})

local colorscheme = "kanagawa"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
