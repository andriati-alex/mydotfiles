return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		opts = function(_, opts)
			local parsers = {
				"bash",
				"c",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"rust",
				"toml",
			}
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, parsers)
			end

			-- Example: enable/disable features
			opts.highlight = { enable = true }
			opts.indent = { enable = true }
			opts.folds = { enable = true } -- LazyVim enables this by default

			-- Enable treesitter
			vim.api.nvim_create_autocmd("FileType", {
				pattern = parsers,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},

	-- Separate spec for autotag (this replaces the old autotag module)
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" }, -- lazy-load on same events
		opts = {}, -- defaults are fine; can customize here if needed
		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
		end,
	},
}
