vim.pack.add({
	"https://github.com/ahkohd/buffer-sticks.nvim",
})

local sticks = require("buffer-sticks")
sticks.setup({
	filter = { buftypes = { "terminal" } },
	highlights = {
		active = { link = "Statement" },
		inactive = { link = "Whitespace" },
		label = { link = "Comment" },
	},
})
sticks.show()
