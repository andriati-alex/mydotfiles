local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then -- Files bigger than 100kb
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require('telescope').setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        buffer_previewer_maker = new_maker,
        layout_strategy = 'flex',
        layout_config = {
            flex = {
                flip_columns = 120,
            },
            vertical = {
                anchor = 'E',
                height = 0.9,
                width = 0.84,
                preview_height = 0.5,
                preview_cutoff = 20,
            },
            horizontal = {
                anchor = 'E',
                height = 0.8,
                width = 0.9,
                preview_width = 0.55,
                preview_cutoff = 40,
            }
        },
        mappings = {
            n = {
                ["<M-p>"] = require("telescope.actions.layout").toggle_preview
            },
            i = {
                ["<M-p>"] = require("telescope.actions.layout").toggle_preview
            }
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
        }
    }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')


vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd> lua require('telescope.builtin').find_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd> lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd> lua require('telescope.builtin').buffers()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd> lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
