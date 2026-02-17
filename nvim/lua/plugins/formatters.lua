return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>;",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			markdown = { "prettier" },
			yaml = { "prettier" },
			json = { "prettier" },
			go = { "golines" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- go = { "goimports", "gofmt" },
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			golines = {
				prepend_args = { "-m", "88" },
			},
		},
	},
}
