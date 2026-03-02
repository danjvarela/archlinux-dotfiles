---@brief
---
--- https://github.com/antonk52/basics-language-server/
---
--- Buffer, path, and snippet completion
---
--- ```sh
--- npm install -g basics-language-server
--- ```

---@type vim.lsp.Config
return {
	cmd = {
		vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "basics-language-server"),
	},
	settings = {
		buffer = {
			enable = true,
			minCompletionLength = 4,
		},
		path = {
			enable = true,
		},
		snippet = {
			enable = false,
			sources = {},
		},
	},
}
