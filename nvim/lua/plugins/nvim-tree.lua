return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set("n", "<leader>l", api.tree.change_root_to_node, opts("Change workdir into cursor"))
		end

		require("nvim-tree").setup({
			view = {
				width = 35,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			git = {
				ignore = false,
			},
			on_attach = on_attach,
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
		})

        -- Global keymaps
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer" })
		vim.keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "[E]xplorer [F]ind and open on current file" }
		)
		vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "[E]xplorer file [C]ollapse" }) -- collapse file explorer
		vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "[E]xplorer file [R]efresh" }) -- refresh file explorer
	end,
}
