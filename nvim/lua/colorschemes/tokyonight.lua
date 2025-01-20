return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		style = "night",
		transparent = true,
		on_highlights = function(hl, c)
			hl.TelescopeNormal = {
				bg = "none",
				fg = c.fg_dark,
			}
			hl.TelescopeBorder = {
				bg = "none",
				fg = c.fg_dark,
			}
			hl.TelescopePromptBorder = {
				bg = "none",
				fg = c.red,
			}
			hl.TelescopePromptTitle = {
				bg = "none",
				fg = c.red,
			}
			hl.TelescopePreviewTitle = {
				fg = c.red,
			}
			hl.TelescopeResultsTitle = {
				fg = c.red,
			}
			hl.BufferLineDevIconLua = {
				bg = "#0f1014",
			}
			hl.BufferLineDevIconLuaSelected = {
				bg = "#14161b",
				fg = c.orange,
			}
			hl.BufferLineDevIconLuaInactive = {
				bg = "#14161b",
				fg = c.blue,
			}
			hl.NvimTreeNormal = {
				bg = "none",
			}
			hl.NvimTreeNormalNC = {
				bg = "none",
			}
		end,
	},
}
