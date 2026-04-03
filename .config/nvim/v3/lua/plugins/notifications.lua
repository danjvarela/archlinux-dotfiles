vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.notify", version = vim.version.range("^v0.17.0") },
})

require("mini.notify").setup()
