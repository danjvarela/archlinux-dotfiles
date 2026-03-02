vim.pack.add({
	"https://github.com/MagicDuck/grug-far.nvim",
})

local grug_far = require("grug-far")

grug_far.setup()

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
	grug_far.open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Search and replace (current file)" })

vim.keymap.set({ "n", "v" }, "<leader>sR", function()
	grug_far.open()
end, { desc = "Search and replace (workspace)" })
