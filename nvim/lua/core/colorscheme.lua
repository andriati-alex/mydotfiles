local colorscheme_name = "tokyonight"
local status_color, _ = pcall(require, colorscheme_name)
if not status_color then
    vim.notify("Problem to find colorscheme " .. colorscheme_name)
else
    vim.cmd.colorscheme(colorscheme_name)
end
