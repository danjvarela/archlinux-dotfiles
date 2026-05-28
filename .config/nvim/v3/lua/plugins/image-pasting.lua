vim.pack.add({
	{ src = "https://github.com/hakonharnes/img-clip.nvim", version = vim.version.range("^v0.6.0") },
})

require("img-clip").setup()
