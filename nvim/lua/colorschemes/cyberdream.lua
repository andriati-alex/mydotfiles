return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		-- Enable transparent background
		transparent = true,
		theme = {
			saturation = 0.7,
			highlights = {
				-- Highlight groups to override, adding new groups is also possible
				-- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values
				-- Example:
				Comment = { fg = "#696969", bg = "NONE", italic = true },
				-- Complete list can be found in `lua/cyberdream/theme.lua`
			},
			-- Override a highlight group entirely using the color palette
			overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
				-- Example:
				return {
					Comment = { fg = colors.grey, bg = "NONE", italic = true },
					["@property"] = { fg = colors.magenta, bold = true },
				}
			end,
		},
	},
}
