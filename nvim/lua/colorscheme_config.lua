--[[ The colorschme --]]

-- Some that are really worth to try out
-- kanagawa
-- darkplus
-- tokyonight
-- onedark
-- catppuccin
-- rosepine

local colorscheme_name = "rose-pine"
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
            cTSOperator = { fg = "#acdfdf", fmt = "bold" },
            cTSConstant = { fg = "#af8030" },
            LspSignatureActiveParameter = { fg = "#5affff", fmt = "bold,underline" },
            -- TSPunctBracket = { fg = "#ffa020" },
            TSType = { fmt = "italic" },
            TSVariable = { fg = "#cfcf9a" },
            cmakeTSVariable = { fg = "#99809e" },
            Pmenu = { bg = "#140022" },
            CmpItemAbbrMatch = { fg = "#07ffff", fmt = "bold" },
            rainbowcol1 = { fg = "#30e0e0", fmt = "bold" },
            rainbowcol2 = { fg = "#afb04f" },
            rainbowcol3 = { fg = "#efef50" },
            rainbowcol4 = { fg = "#ef7040" },
            rainbowcol5 = { fg = "#d060d0" },
            rainbowcol6 = { fg = "#5f8fd0" },
            rainbowcol7 = { fg = "#30e0e0" },
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
    colorscheme.setup({
        transparent = true,
        styles = { sidebars = "transparent" },
        on_highlights = function(hl, c)
            hl.StatusLine = { bg = "none" }
            hl.CursorLineNr = { fg = c.orange, style = "bold" }
            hl.TabLineFill = { bg = "none" }
            hl.rainbowcol1 = { fg = "#30e0e0" }
            hl.rainbowcol2 = { fg = "#afb04f" }
            hl.rainbowcol3 = { fg = "#efef50" }
            hl.rainbowcol4 = { fg = "#ef7040" }
            hl.rainbowcol5 = { fg = "#d060d0" }
            hl.rainbowcol6 = { fg = "#5f8fd0" }
            hl.rainbowcol7 = { fg = "#30e0e0" }
            hl.CursorLine = { bg = "#161616" }
        end,
    })
end

if colorscheme_name == "rose-pine" then
    colorscheme.setup({
        dark_variant = 'moon',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = true,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
            background = 'base',
            panel = 'surface',
            border = 'highlight_med',
            comment = 'muted',
            link = 'iris',
            punctuation = 'subtle',

            error = 'love',
            hint = 'iris',
            info = 'foam',
            warn = 'gold',

            headings = {
                h1 = 'iris',
                h2 = 'foam',
                h3 = 'rose',
                h4 = 'gold',
                h5 = 'pine',
                h6 = 'foam',
            }
        },

        -- Change specific vim highlight groups
        highlight_groups = {
            ColorColumn = { bg = "rose" },
            StatusLine = { bg = "none" },
            TabLineFill = { bg = "none" },
            CursorLineNr = { fg = "rose" },
            Pmenu = { bg = "#000000" },
            PmenuSel = { bg = "base" },
            CmpItemAbbrMatch = { fg = "gold", style = "bold"},
            CmpItemAbbrMatchFuzzy = { fg = "#b29265", style = "underline"},
            LspSignatureActiveParameter = { fg = "gold", style = "bold" },
        }
    })
end

if colorscheme_name == "catppuccin" then
    vim.g.catppuccin_flavour = "frappe"
    colorscheme.setup({
        transparent_background = true,
        custom_highlights = {
            StatusLine = { bg = "none", style = { "bold" } },
            rainbowcol1 = { fg = "#30e0e0" },
            rainbowcol2 = { fg = "#afb04f" },
            rainbowcol3 = { fg = "#efef50" },
            rainbowcol4 = { fg = "#ef7040" },
            rainbowcol5 = { fg = "#d060d0" },
            rainbowcol6 = { fg = "#5f8fd0" },
            rainbowcol7 = { fg = "#30e0e0" },
            CursorLine = { bg = "#161616" },
            NormalFloat = { bg = "none" },
            CursorLineNr = { fg = "#55eeaa", style = { "bold" } },
            NvimTreeCursorLine = { bg = "#384561" },
        },
    })
end

vim.cmd.colorscheme(colorscheme_name)
