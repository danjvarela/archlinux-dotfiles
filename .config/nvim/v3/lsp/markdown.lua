return {
	cmd = {
		vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "marksman"),
	},
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".marksman.toml", ".git" },
	single_file_support = true,
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".marksman.toml", ".git" })
		if root and vim.uv.fs_stat(vim.fs.joinpath(root, ".obsidian")) then
			return
		end
		on_dir(root or vim.fn.getcwd())
	end,
}
