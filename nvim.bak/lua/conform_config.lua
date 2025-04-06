local conform_status, conform = pcall(require, "conform")
if not conform_status then
    vim.notify("Something wrong with conform. Is is installed?")
    return
end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "golines" },
        javascript = { "prettier" },
    },
    formatters = {
        golines = {
            prepend_args = { "-m", "80" },
        },
    },
})

vim.keymap.set(
    "n",
    "<leader>;",
    function()
        require("conform").format({ async = true, lsp_fallback = true })
    end,
    { noremap = true, silent = true }
)
