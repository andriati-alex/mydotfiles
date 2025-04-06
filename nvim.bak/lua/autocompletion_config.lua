--[[ Autocompletion configuration

Autocompletion here also include lua-snippets

--]]

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("Problem to load cmp. Is it installed?")
    return
end

-- Snippets loading
local snippets_status, luasnip = pcall(require, "luasnip")
if not snippets_status then
    vim.notify("Problem to load luasnip. Is it installed?")
    return
else
    require("luasnip/loaders/from_vscode").lazy_load()
end

-- Expand or jump snippets keybindings
vim.keymap.set(
    "i",
    "<c-k>",
    "<cmd>lua if require('luasnip').jumpable(1) then require('luasnip').jump(1) end<CR>"
)

vim.keymap.set(
    "i",
    "<c-j>",
    "<cmd>lua if require('luasnip').jumpable(-1) then require('luasnip').jump(-1) end<CR>"
)

-- Function to handle properly the backspace while completing
local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- nvim-cmp setup
-- inspired on plugin page https://github.com/hrsh7th/nvim-cmp/
-- see also:
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/LunarVim/Neovim-from-scratch/blob/05-completion/lua/user/cmp.lua

local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false, -- If true, take the first option if none is selected
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        {
            name = "dictionary",
            keyword_length = 3,
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
            },
        },
        { name = "nvim_lua" },
        { name = "buffer" },
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            maxwidth = 50,
            maxheight = 10,
        },
    },
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons with names of the completion field
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            -- Sources
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                dictionary = "[Dict]",
                path = "[Path]",
                nvim_lua = "[Vim]",
                buffer = "[Buffer]",
            })[entry.source.name]
            return vim_item
        end,
    },
    experimental = { ghost_text = true },
})

-- The source for the dictionary must be a plain text file. A way to generate
-- such a file is with the following command:
-- aspell -d en_US dump master | aspell -l en expand > american_english.dic
-- Aspell package and languages installation https://www.linuxfromscratch.org/blfs/view/stable/general/aspell.html
local dict_path = vim.fn.expand("~/.config/dicts/american_english.dic")
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = { "markdown", "text", "yaml" },
        callback = function()
            require("cmp_dictionary").setup({
                paths = { dict_path },
                exact_length = 3,
                first_case_insensitive = true,
                document = {
                    enable = true,
                    command = { "wn", "${label}", "-over" }, -- need to install wordnet-cli
                },
            })
        end,
    }
)


cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
