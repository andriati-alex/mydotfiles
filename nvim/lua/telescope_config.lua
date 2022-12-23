--[[ A fuzzy finder plugin --]]

-- Use a protected call so we don't get errors on first use
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("Problem to config Telescope. Is it installed?")
    return
end

local previewers = require("telescope.previewers")
local layouts = require("telescope.actions.layout")

local new_maker = function(filepath, bufnr, opts)
    -- New maker to avoid showing too large files
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
            return
        end
        if stat.size > 100000 then -- Files bigger than 100kb
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

telescope.setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        buffer_previewer_maker = new_maker,
        layout_strategy = "flex",
        layout_config = {
            flex = {
                flip_columns = 120,
            },
            vertical = {
                anchor = "E",
                height = 0.9,
                width = 0.84,
                preview_height = 0.5,
                preview_cutoff = 20,
            },
            horizontal = {
                anchor = "E",
                height = 0.8,
                width = 0.9,
                preview_width = 0.55,
                preview_cutoff = 40,
            },
        },
        mappings = {
            n = {
                ["<M-p>"] = layouts.toggle_preview,
            },
            i = {
                ["<M-p>"] = layouts.toggle_preview,
            },
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
        file_ignore_patterns = {
            ".*__pycache__*.",
            "(?!.*[.](c|py)$).*build.*",
            ".*.dat$",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- ## Default Mappings
--
-- Mappings are fully customizable.
-- Many familiar mapping patterns are setup as defaults.
--
-- | Mappings       | Action                                               |
-- |----------------|------------------------------------------------------|
-- | `<C-n>/<Down>` | Next item                                            |
-- | `<C-p>/<Up>`   | Previous item                                        |
-- | `j/k`          | Next/previous (in normal mode)                       |
-- | `H/M/L`        | Select High/Middle/Low (in normal mode)              |
-- | 'gg/G'         | Select the first/last item (in normal mode)          |
-- | `<CR>`         | Confirm selection                                    |
-- | `<C-x>`        | Go to file selection as a split                      |
-- | `<C-v>`        | Go to file selection as a vsplit                     |
-- | `<C-t>`        | Go to a file in a new tab                            |
-- | `<C-u>`        | Scroll up in preview window                          |
-- | `<C-d>`        | Scroll down in preview window                        |
-- | `<C-/>`        | Show mappings for picker actions (insert mode)       |
-- | `?`            | Show mappings for picker actions (normal mode)       |
-- | `<C-c>`        | Close telescope                                      |
-- | `<Esc>`        | Close telescope (in normal mode)                     |
-- | `<Tab>`        | Toggle selection and move to next selection          |
-- | `<S-Tab>`      | Toggle selection and move to prev selection          |
-- | `<C-q>`        | Send all items not filtered to quickfixlist (qflist) |
-- | `<M-q>`        | Send all selected items to qflist                    |
