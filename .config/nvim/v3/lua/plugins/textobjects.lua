vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.ai", version = vim.version.range("^v0.17.0") },
})

require("mini.ai").setup()
