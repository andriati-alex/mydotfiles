local lint_status, lint = pcall(require, "lint")
if not lint_status then
    vim.notify("Something wrong with conform. Is is installed?")
    return
end

local mypy = lint.linters.mypy
mypy.args = {
    '--show-column-numbers',
    '--show-error-end',
    '--no-color-output',
    '--no-pretty',
    '--ignore-missing-imports'
}

lint.linters_by_ft = {
    python = { "mypy" },
    terraform = { "tflint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWritePost", "InsertLeave" },
    {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    }
)
