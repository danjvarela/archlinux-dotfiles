vim.pack.add({
	{ src = "https://github.com/A7Lavinraj/fyler.nvim", version = vim.version.range("^v2.0.0") },
})

local fyler = require("fyler")

fyler.setup({
	views = {
		finder = {
			close_on_select = false,
			win = {
				kinds = {
					split_left_most = {
						width = "20%",
						win_opts = {
							winfixwidth = true,
						},
					},
				},
			},
			watcher = { enabled = true },
			columns_order = { "diagnostic", "git" },
			columns = {
				git = {
					enabled = true,
					symbols = {
						Untracked = "",
						Added = "",
						Modified = "",
						Deleted = "",
						Renamed = "",
						Copied = "",
						Conflict = "",
						Ignored = "",
					},
				},
				diagnostic = {
					enabled = "true",
					symbols = {
						Error = "",
						Warn = "",
						Info = "",
						Hint = "",
					},
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>e", function()
	fyler.toggle({ kind = "split_left_most" })
end, { desc = "Open File Explorer" })
