return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Move next hunk" })
			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Move previous hunk" })

			-- Actions
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk to [S]tage area" })
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset from stage" })

			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk to [S]tage area inside selection" })

			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk [R]eset from stage inside selection" })

			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[H]unk [S]tage buffer" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[H]unk [R]eset buffer" })

			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "[H]unk [B]lame" })

			-- Diff
			map("n", "<leader>hd", gitsigns.diffthis, { desc = "[H]unk [D]iff" })
			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "[H]unk [D]iff all" })

			-- Send to quick-fix list
			map("n", "<leader>hq", gitsigns.setqflist, { desc = "[H]unk to [Q]uick-fix list" })
			map("n", "<leader>hQ", function()
				gitsigns.setqflist("all")
			end, { desc = "All [H]unks to [Q]uick-fix list" })

			-- Toggles
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle cursor line [B]lame" })
			map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[T]oggle [W]ord diff" })
		end,
	},
}
