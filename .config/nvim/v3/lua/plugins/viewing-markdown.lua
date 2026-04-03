vim.pack.add({
	{ src = "https://github.com/OXY2DEV/markview.nvim", version = vim.version.range("^v28.1.0") },
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("^v3.16.0") },
})

require("markview").setup({
	preview = {
		icon_provider = "mini",
		filetypes = { "markdown", "codecompanion" },
	},
	yaml = {
		properties = {
			enable = true,
			data_types = {
				["text"] = {
					text = "≡ ",
					hl = "MarkviewIcon4",
				},
				["list"] = {
					text = "󰝖 ",
					hl = "MarkviewIcon5",
				},
				["number"] = {
					text = " ",
					hl = "MarkviewIcon6",
				},
				["checkbox"] = {
					---@diagnostic disable
					text = function(_, item)
						return item.value == "true" and "󰄲 " or "󰄱 "
					end,
					---@diagnostic enable
					hl = "MarkviewIcon6",
				},
				["date"] = {
					text = "󰃭 ",
					hl = "MarkviewIcon2",
				},
				["date_&_time"] = {
					text = "󰥔 ",
					hl = "MarkviewIcon3",
				},
			},
		},
	},
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
