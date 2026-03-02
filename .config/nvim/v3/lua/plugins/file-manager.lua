vim.pack.add({
	{
		src = "https://github.com/A7Lavinraj/fyler.nvim",
		version = "stable",
	},
})
local fyler = require("fyler")
fyler.setup()
vim.keymap.set("n", "<leader>e", function()
	fyler.toggle({ kind = "split_left_most" })
end, { desc = "Open fyler View" })
