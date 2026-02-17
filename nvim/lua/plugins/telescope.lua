return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		"folke/todo-comments.nvim",
	},
	event = "VimEnter",
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, 'ui-select')

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]uzzy find files in cwd" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]uzzy find [R]ecent files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind with live [G]rep" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind string under cursor in cwd" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]uzzy find in neovim [H]elp" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing buffers" })
		vim.keymap.set("n", "<leader>fs", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "[F]ind [S]tring and pipe to grep" })

		-- More elaborated keymaps
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[F]uzzy live grep [/] in Open Files" })
	end,
}
