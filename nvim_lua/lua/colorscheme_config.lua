--[[ The colorschme --]]

-- Some that are really worth to try out
-- sonokai
-- kanagawa
-- darkplus
-- tokyonight
-- onedark

--vim.cmd [[let g:sonokai_style = 'shusia' ]]
--vim.cmd [[let g:sonokai_transparent_background = 1 ]]
--vim.cmd [[let g:sonokai_enable_italic = 1 ]]
--vim.cmd [[let g:sonokai_diagnostic_virtual_text = 'colored' ]]
--vim.cmd [[let g:sonokai_diagnostic_text_highlight = 1 ]]
--vim.cmd [[let g:sonokai_current_word = 'underline' ]]

local colorscheme_name = "onedark"
local status_color, colorscheme = pcall(require, colorscheme_name)
if not status_color then
    vim.notify("Problem to find colorscheme " .. colorscheme_name)
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

if colorscheme_name == "onedark" then
    colorscheme.setup({
        -- Main options --
        style = "warmer", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        -- toggle theme style ---
        toggle_style_key = "<leader>ts", -- Default keybinding to toggle
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = "italic",
            keywords = "bold",
            functions = "none",
            strings = "none",
            variables = "none",
        },

        -- Custom Highlights --
        -- use :lua require('telescope.builtin').highlights()
        colors = {}, -- Override default colors
        highlights = {
            CursorLineNr = { fg = "#ff1e8c", fmt = "bold" },
            cTSOperator = { fg = "#ffffbc", fmt = "bold" },
            LspSignatureActiveParameter = { fg = "#5affff", fmt = "bold,underline" },
            TSPunctBracket = { fg = "#ffa020" },
            TSType = { fmt = "italic" },
            TSVariable = { fg = "#ffffbe" },
            cmakeTSVariable = { fg = "#99809e" },
            Pmenu = { bg = "#140022" },
            CmpItemAbbrMatch = { fg = "#07ffff", fmt="bold" },
            rainbowcol1 = { fg = "#30e0e0", fmt = "bold"},
            rainbowcol2 = { fg = "#afb04f"},
            rainbowcol3 = { fg = "#efef50"},
            rainbowcol4 = { fg = "#ef7040"},
            rainbowcol5 = { fg = "#d060d0"},
            rainbowcol6 = { fg = "#5f8fd0"},
            rainbowcol7 = { fg = "#30e0e0"},
            StatusLine = { bg = "none" },
            -- TabLine = { bg = "none" },
            TabLineFill = { bg = "none" },
        }, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
            darker = true, -- darker colors for diagnostic
            undercurl = true, -- use undercurl instead of underline for diagnostics
            background = false, -- use background color for virtual text
        },
    })
end

if colorscheme_name == "tokyonight" then
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
    vim.g.tokyonight_colors = { bg_float = "none", bg_sidebar = "none" }
    vim.api.nvim_exec(
        [[
            augroup MyColors
                autocmd!
                autocmd ColorScheme * highlight CursorLineNr guifg=#FF0099
            augroup END
        ]],
        false
    )
end

local status_cmd, _ = pcall(vim.cmd, "colorscheme " .. colorscheme_name)
if not status_cmd then
    vim.notify("colorscheme " .. colorscheme_name .. " not found!")
    return
end
