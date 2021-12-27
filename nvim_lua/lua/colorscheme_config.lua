--[[ The colorschme --]]

-- Some that are really worth to try out
-- sonokai
-- kanagawa
-- darkplus
local colorscheme = "kanagawa"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
