--[[ The colorschme --]]
-- Some that are really worth to try out
-- kanagawa
-- darkplus
-- tokyonight
-- onedark
-- catppuccin
-- rosepine

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
        specialReturn = true,    -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = true,      -- do not set background color
        colors = {},
        overrides = overrides_fields,
    })
end

if colorscheme_name == "onedark" then
    colorscheme.setup({
        -- Main options --
        style = "dark",                                                                      -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true,                                                                  -- Show/hide background
        term_colors = true,                                                                  -- Change terminal color as per the selected theme style
        ending_tildes = false,                                                               -- Show the end-of-buffer tildes. By default they are hidden
        -- toggle theme style ---
        toggle_style_key = "<leader>ts",                                                     -- Default keybinding to toggle
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = "italic",
            keywords = "italic",
            functions = "none",
            strings = "none",
            variables = "none",
            conditionals = "italic"
        },
        -- Custom Highlights --
        -- use :lua require('telescope.builtin').highlights()
        colors = {}, -- Override default colors
        highlights = {
            ["@variable.parameter"] = { fg = '#c16464', fmt = 'italic' },
            ["@string"] = { fg = '$green' },
            ["@string.documentation"] = { fg = '#9d7c6c' },
            CursorLineNr = { fg = "#ff1e8c"},
            LspSignatureActiveParameter = { fg = "#5affff", fmt = "bold,underline" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none", fg = "$cyan", fmt = "bold" },
            Pmenu = { bg = "none" },
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
        lualine = {
            transparent = true, -- lualine center bar transparency
        },
        diagnostics = {
            darker = true,      -- darker colors for diagnostic
            undercurl = true,   -- use undercurl instead of underline for diagnostics
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
        variant = "main",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
            terminal = true,
            legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
            migrations = true,        -- Handle deprecated options automatically
        },

        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },

        groups = {
            border = "muted",
            link = "iris",
            panel = "surface",

            error = "love",
            hint = "iris",
            info = "foam",
            note = "pine",
            todo = "rose",
            warn = "gold",

            git_add = "foam",
            git_change = "rose",
            git_delete = "love",
            git_dirty = "rose",
            git_ignore = "muted",
            git_merge = "iris",
            git_rename = "pine",
            git_stage = "iris",
            git_text = "rose",
            git_untracked = "subtle",

            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
        },
        -- Change specific vim highlight groups
        highlight_groups = {
            ColorColumn = { bg = "rose" },
            StatusLine = { bg = "none" },
            TabLineFill = { bg = "none" },
            CursorLineNr = { fg = "rose" },
            Pmenu = { bg = "#000000" },
            PmenuSel = { bg = "base" },
            CmpItemAbbrMatch = { fg = "gold", bold = true },
            CmpItemAbbrMatchFuzzy = { fg = "#b29265", underline = true },
            LspSignatureActiveParameter = { fg = "gold", bold = true },
        }
    })
end

if colorscheme_name == "catppuccin" then
    colorscheme.setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        background = {      -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false,           -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15,         -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" },   -- Change the style of comments
            conditionals = { "italic" },
            loops = { "italic" },
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = function(colors)
            return {
                StatusLine = { bg = colors.none },
                TabLineFill = { bg = colors.none },
                TabLineSel = { bg = colors.pink },
                CmpBorder = { fg = colors.surface2 },
                Pmenu = { bg = colors.none },
            }
        end,
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end

vim.cmd.colorscheme(colorscheme_name)
