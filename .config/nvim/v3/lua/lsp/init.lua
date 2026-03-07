vim.lsp.enable({
	"astro",
	"lua",
	"paths-buffers-snippets",
	"csharp",
	"css",
	"css-variables",
	"json",
	"markdown",
	"svelte",
	"tailwind",
	"typescript",
	"eslint",
})

local icons = {
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
			local map = vim.keymap.set

      -- stylua: ignore start
			map("n", "gk", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
			map("i", "<c-k>", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help" })

			map({ "n", "v" }, "grc",function() vim.lsp.codelens.run() end, { desc = "Codelens" })
			-- stylua: ignore end
		end
	end,
})

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
		},
	},
})
