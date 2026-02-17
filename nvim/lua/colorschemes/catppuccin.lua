return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		transparent_background = true, -- disables setting the background color.
		custom_highlights = function(colors)
			return {
				NotifyBackground = { bg = colors.base },
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
			}
		end,
	},
}
