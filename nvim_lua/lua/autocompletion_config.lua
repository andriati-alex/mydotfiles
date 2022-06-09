--[[ Autocompletion and LSP configuration

Python
    # install basic engines
    python -m pip install --user --upgrade black mypy pyflakes pycodestyle pydocstyle
    # install language server itself and jedi for completions
    python -m pip install --user --upgrade python-lsp-server jedi
    # install extensions
    python -m pip install --user --upgrade 'python-lsp-server[pyflakes]' 'python-lsp-server[pycodestyle]' 'python-lsp-server[pydocstyle]' pylsp-mypy python-lsp-black
    npm install -g pyright

Cmake
    python -m pip install --user --upgrade cmake-language-server

--]]

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("Problem to load cmp. Is it installed?")
    return
end

-- Snippets loading
local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    vim.notify("Problem to load luasnip. Is it installed?")
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- Expand or jump snippets keybindings
vim.api.nvim_set_keymap(
    "i",
    "<c-k>",
    "<cmd>lua if require('luasnip').jumpable(1) then require('luasnip').jump(1) end<CR>",
    { silent = true }
)

vim.api.nvim_set_keymap(
    "i",
    "<c-j>",
    "<cmd>lua if require('luasnip').jumpable(-1) then require('luasnip').jump(-1) end<CR>",
    { silent = true }
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
        { name = "dictionary", keyword_length = 2 },
        { name = "path" },
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
local dict_path = vim.fn.expand("~/.config/dicts/american_english.dic")
local dict_ok, cmp_dict = pcall(require, "cmp_dictionary")
if dict_ok then
    cmp_dict.setup({
        dic = {
            ["tex,markdown,text"] = dict_path,
        },
        -- The following are default values, so you don't need to write them if you don't want to change them
        exact = 2,
        async = true, -- requires lua51-mpack installed
        capacity = 5,
        debug = false,
    })
end

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- required in the following lsp setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- LSP Configuration

local lsp_status_ok, nvim_lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
    vim.notify("Something wrong with lspconfig. Is is installed?")
    return
end

-- function to hightlight variable under cursor
local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

-- General on-attach
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings options
    local opts = { noremap = true, silent = true }

    -- maintain signature while typing
    local sig_help_ok, lsp_signature = pcall(require, "lsp_signature")
    if sig_help_ok then
        lsp_signature.on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = true,
            hint_prefix = " ",
            handler_opts = {
                border = "rounded",
            },
        }, bufnr)
    end

    -- highlight current variable on cursor hovering
    lsp_highlight_document(client)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<space>;", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- LSP UI customization

-- Auto show popup with diagnostics
vim.cmd(
    [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, source="always", scope="cursor"})]]
)

local lsp_borders = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Override the borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    -- opts.border = opts.border or lsp_borders
    opts.border = lsp_borders
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Configure each language server

local lua_runtime_path = vim.split(package.path, ";")
table.insert(lua_runtime_path, "lua/?.lua")
table.insert(lua_runtime_path, "lua/?/init.lua")
nvim_lspconfig["sumneko_lua"].setup({
    settings = {
        Lua = {
            runtime = {
                path = lua_runtime_path,
            },
            diagnostics = {
                -- Recognize vim global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

nvim_lspconfig["cmake"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lspconfig["ccls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        compilationDatabaseDirectory = "build",
        index = {
            threads = 2,
        },
        cache = {
            directory = ".ccls-cache",
        },
    },
})

-- Some time ago I felt a sligth delay on closing python files
nvim_lspconfig["pylsp"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                -- pydocstyle is disabled by default
                pyflakes = {
                    enabled = true,
                },
                pycodestyle = {
                    enabled = true,
                    ignore = { "W605", "W503", "E203" },
                },
                jedi_completion = {
                    enabled = true,
                    fuzzy = true,
                },
                rope_completion = {
                    enabled = false,
                },
                -- https://github.com/Richardk2n/pylsp-mypy
                -- check all options passed to `overrides` with `$ mypy --help$`
                -- Avoid messing the `overrides` for specific particular needs.
                -- instead use a configuration file. See mypy documentation.
                pylsp_mypy = {
                    enabled = true,
                    live_mode = false,
                    dmypy = false, -- Enable with `live_mode = false` to improve lsp reponsiveness
                    overrides = {
                        "--ignore-missing-imports",
                        "--show-column-numbers",
                        "--show-error-codes",
                        true,
                    },
                },
            },
        },
    },
})

-- custom on attach to avoid using tsserver formatter
nvim_lspconfig["tsserver"].setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
})

--[[ A general multi-purposes diagnostic server

This is a very general tool that support running several linting engines,
formatters and language servers simultaneously. I tested it only with
`mypy` trying to reproduce the default lsp behavior and it worked.

Official page:
https://github.com/iamcco/diagnostic-languageserver

The author also provide specific Coc settings (may be useful)
https://github.com/iamcco/coc-diagnostic

WARNING:
The configuration fields are not well documented in the nvim lsp page
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#diagnosticls

Thus the following issue can be useful
https://github.com/iamcco/diagnostic-languageserver/issues/72

See all available linters at
https://github.com/iamcco/diagnostic-languageserver/wiki/Linters#mypy

--]]

--nvim_lspconfig['diagnosticls'].setup{
--    on_attach = on_attach,
--    capabilities = capabilities,
--    filetypes = {
--        "python",
--    },
--    init_options = {
--        linters = {
--            mypy = {
--                sourceName = "mypy",
--                command= "mypy",
--                args= {
--                    --"--disallow-untyped-calls", -- cannot call untyped functions from typed ones
--                    --"--disallow-untyped-defs", -- only typed functions can be defined
--                    --"--check-untyped-defs", -- check inside untyped functions
--                    "--ignore-missing-imports", -- avoid over-reporting errors from external packages
--                    "--show-error-codes",
--                    "--no-color-output",
--                    "--no-error-summary",
--                    "--show-column-numbers",
--                    "--follow-imports=silent",
--                    --"--python-executable",
--                    --"/usr/bin/python3",
--                    "%file"
--                },
--                formatPattern =  {
--                    "^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$",
--                    {
--                        line = 1,
--                        column = 2,
--                        security = 3,
--                        message = 4
--                    }
--                },
--                --securities =  {
--                --    error = "error"
--                --},
--            },
--        },
--        filetypes = {
--            python = "mypy",
--        },
--    },
--}

--[[ Null-ls

The Null-ls plugin provide a bridge to use more external sources to
feed the neovim LSP. It is very much like diagnostic-languageserver
described above but written in lua. Even in the README, among the
listed alternative they mention the diagnostic-languageserver

--]]

local null_ls = require("null-ls")

-- local pylintrc_file = vim.fn.expand("~/.config/pylint/pylintrc")
null_ls.setup({
    sources = {
        -- null_ls.builtins.diagnostics.pylint.with({
        --     extra_args = {"--rcfile", "/home/andriati/.config/pylint/pylintrc"},
        --     method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        -- }),
        null_ls.builtins.formatting.prettier.with({
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote", "--tab-width", "4" },
        }),
        null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        -- django html
        null_ls.builtins.formatting.djhtml,
    },
    on_attach = on_attach,
})
