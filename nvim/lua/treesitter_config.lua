--[[ Plugin to provide amazing color highlight syntax --]]

-- Use a protected call so we don't get errors on first use
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("Problem to config Tresitter. Is it installed?")
    return
end

configs.setup({
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    auto_install= false,
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    -- indent = { enable = true, disable = { "yaml" } },
    rainbow = {
        enable = true,
        disable = { "html" },
    },
})
