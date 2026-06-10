---@brief
---
--- https://github.com/Feel-ix-343/markdown-oxide
---
--- Editor Agnostic PKM: you bring the text editor and we
--- bring the PKM.
---
--- Inspired by and compatible with Obsidian.
---
--- Check the readme to see how to properly setup.

---@param client vim.lsp.Client
---@param bufnr integer
---@param cmd string
local function command_factory(client, bufnr, cmd)
	return client:exec_cmd({
		title = ("Markdown-Oxide-%s"):format(cmd),
		command = "jump",
		arguments = { cmd },
	}, { bufnr = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

---@type vim.lsp.Config
return {
	root_markers = { ".git", ".obsidian", ".moxide.toml" },
	filetypes = { "markdown" },
	cmd = {
		vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "markdown-oxide"),
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_create_user_command("Daily", function(args)
			local input = args.args

			command_factory(client, bufnr, input)
		end, { desc = "Open daily note", nargs = "*" })
	end,
	capabilities = capabilities,
}
