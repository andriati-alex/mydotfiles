--[[ Language servers package management (Mason)
--
-- Mason is a plugin to manage Server side instalation for LSP communication,
-- with neovim at the client side. Nonetheless, it might depend on external
-- sources, such as having python installed before installing python related
-- servers, formatters or linters.
--
-- Enter Mason interface with :Mason, see available servers and increment the
-- lists provided below for adding new ones. More information on customizing
-- each server in `lsp-config.lua` file
--]]

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup()

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"html",
				"cssls",
				"lua_ls",
				"ruff",
				"docker_compose_language_service",
				"dockerls",
				"yamlls",
				"jsonls",
				"jinja_lsp",
				"terraformls",
				"bashls",
				"pyright",
				"gopls",
			},
			automatic_installation = true,
		})

		-- Additional formatters and linters only
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"eslint_d",
				"mypy",
				"shfmt",
				"revive",
			},
		})
	end,
}
