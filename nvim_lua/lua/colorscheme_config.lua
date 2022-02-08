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

local colorscheme_name = "kanagawa"
local status_color, colorscheme = pcall(require, colorscheme_name)
if not status_color then
    vim.notify("Problem to find colorscheme " .. colorscheme_name)
    return
end

-- Options specific for Kanagawa:
if colorscheme_name == "kanagawa" then
    local overrides_fields = {
        TSOperator = { style = "bold" },
    }

    colorscheme.setup({
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
end

local status_cmd, _ = pcall(vim.cmd, "colorscheme " .. colorscheme_name)
if not status_cmd then
    vim.notify("colorscheme " .. colorscheme_name .. " not found!")
    return
end
