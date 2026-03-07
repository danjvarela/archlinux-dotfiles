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

vim.keymap.set({ "n", "v" }, "<leader>jj", function()
	BufferSticks.jump()
end, { desc = "Jump to buffer" })

vim.keymap.set({ "n", "v" }, "<leader>jq", function()
	BufferSticks.close()
end, { desc = "Close buffer" })

vim.keymap.set({ "n", "v" }, "<leader>jp", function()
	BufferSticks.list({
		action = function(buffer, leave)
			print("Selected: " .. buffer.name)
			leave()
		end,
	})
end, { desc = "Buffer picker" })
