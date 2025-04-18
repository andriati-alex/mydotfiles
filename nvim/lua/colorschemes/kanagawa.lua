return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	name = "kanagawa",
	opts = {
		theme = "lotus", -- Either 'wave', 'dragon' or 'lotus'
		transparent = true, -- do not set background color
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				-- Save an hlgroup with dark background and dimmed foreground
				-- so that you can use it where your still want darker windows.
				-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

				-- Popular plugins that open floats will link to NormalFloat by default;
				-- set their background accordingly if you wish to keep them dark and borderless
				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

				-- Remove Telescope borders
				TelescopeBorder = { bg = "none" },
				NoiceCmdlinePopupBorder = { fg = colors.palette.carpYellow, bg = "none" },

				-- Some borders defaults to it
				DiagnosticSignInfo = { bg = "none" },
			}
		end,
	},
}
