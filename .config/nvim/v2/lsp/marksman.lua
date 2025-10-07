return {
	cmd = {
		vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "marksman"),
	},
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".marksman.toml", ".git" },
	single_file_support = true,
}
