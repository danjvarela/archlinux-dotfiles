vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("roslyn_ls")
vim.lsp.enable("emmet-language-server")

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
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

			local map = vim.keymap.set

      -- stylua: ignore start
			map("i", "<C-Space>", function() vim.lsp.completion.get() end)
			map("n", "gk", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
			map("i", "<c-k>", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

			map(
			  { "n", "v" },
			  "<leader>co",
			  function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports' }, diagnostics = {}, }, })
        end,
			  { desc = "Organize Imports" }
			)

			map({ "n", "v" }, "<leader>cc",function() vim.lsp.codelens.run() end, { desc = "Codelens" })
			map({ "n" }, "<leader>cC", function() vim.lsp.codelens.refresh() end, { desc = "Codelens" })
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
