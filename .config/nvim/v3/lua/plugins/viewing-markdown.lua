vim.pack.add({
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("^v3.16.0") },
})

require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/.second-brain",
		},
	},

	note_id_func = require("obsidian.builtin").title_id,

	daily_notes = {
		folder = "dailies",
	},
})
