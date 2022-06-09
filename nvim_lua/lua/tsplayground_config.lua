--[[ Plugin to provide amazing color highlight syntax --]]

-- a protected call so we don't get errors on first use
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("Problem to config Tresitter. Is it installed?")
    return
end

configs.setup({
    ensure_installed = "maintained",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    -- indent = { enable = true, disable = { "yaml" } },
    playground = {
        enable = true,
    },
})
