vim.pack.add({
	"https://github.com/OXY2DEV/markview.nvim",
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
