vim.pack.add({
	{ src = "https://github.com/hakonharnes/img-clip.nvim", version = vim.version.range("^v0.6.0") },
})

require("img-clip").setup({
	filetypes = {
		codecompanion = {
			prompt_for_file_name = false,
			template = "[Image]($FILE_PATH)",
			use_absolute_path = true,
		},
	},
})
