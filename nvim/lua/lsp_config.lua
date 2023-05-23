--[[ LSP Configuration

Besides all LSP stuff, Mason is used to install Language servers

--]]
local lsp_status_ok, nvim_lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
    vim.notify("Something wrong with lspconfig. Is is installed?")
    return
end

-- function to hightlight variable under cursor
local function lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
            hi! LspReferenceRead cterm=bold ctermbg=red guibg=#1b232d
            hi! LspReferenceText cterm=bold ctermbg=red guibg=#1b232d
            hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#1b232d
        ]])
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false,
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- general configuration
-- checkout :h vim.diagnostic.config
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            return string.format('[%s] %s', diagnostic.code, diagnostic.message)
        end
    }
})

-- function to auto popup floating window diagnostics
local function popup_diagnostics(bufnr)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
                format = function(diagnostic)
                    return string.format('[%s] %s', diagnostic.code, diagnostic.message)
                end,
            }
            vim.diagnostic.open_float(nil, opts)
        end,
    })
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
            handler_opts = { border = "rounded" },
        }, bufnr)
    end

    -- highlight current variable on cursor hovering
    lsp_highlight_document(client, bufnr)

    -- popup diagnostics in floating window
    popup_diagnostics(bufnr)

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
    buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<space>;", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
end

--[[ LSP UI customization --]]
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

-- Setup mason so it can manage external tooling
require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        icons = {
            package_installed = "",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
})

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local ls_servers = { "clangd", "rust_analyzer", "jedi_language_server", "tsserver", "lua_ls", "gopls" }
local extra_servers = { "revive", "eslint_d", "golines", "prettier", "ruff", "mypy" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({ ensure_installed = ls_servers })
require('mason-null-ls').setup({ ensure_installed = extra_servers })

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(ls_servers) do
    nvim_lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

--[[ CUSTOM CONFIGURATION OF SERVERS --]]
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lspconfig["ruff_lsp"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        settings = {
            args = { "--extend-select", "RET", "--extend-select", "ARG", "--extend-select", "C", "--extend-select", "N",
                "--extend-select", "PD", "--extend-ignore", "ARG002" },
        }
    },
})

nvim_lspconfig["lua_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
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

--[[ ADDITIONAL LINTER AND FORMATTERS

The Null-ls plugin provides a bridge to use more external sources to
feed the neovim LSP. It is very much like diagnostic-languageserver.

--]]
--
local loaded_null_ls, null_ls = pcall(require, "null-ls")
if not loaded_null_ls then
    vim.notify("Problem to load null-ls. Is it installed?")
    return
end

null_ls.setup({
    sources = {
        --        null_ls.builtins.diagnostics.ruff.with({
        --            extra_args = { "--extend-select", "RET", "--extend-select", "ARG",
        --                "--extend-select", "C", "--extend-select", "N", "--extend-select", "PD", "--extend-ignore", "ARG002" }
        --        }),
        null_ls.builtins.diagnostics.mypy.with({ extra_args = { "--ignore-missing-imports" }, }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier.with({
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote", "--tab-width", "4" },
        }),
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        -- golang revive linter
        null_ls.builtins.diagnostics.revive.with({
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        }),
        -- golang alternative formatter
        null_ls.builtins.formatting.golines.with({ extra_args = { "-m", "80" } }),
    },
    on_attach = on_attach,
})
