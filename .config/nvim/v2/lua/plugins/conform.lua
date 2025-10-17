return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
    -- stylua: ignore
		{ "<leader>cf", function() require("conform").format({ async = true }) end, mode = "", desc = "Format buffer", },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			vue = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			less = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			["markdown.mdx"] = { "prettierd" },
		},
		default_format_opts = {
			-- default to the lsp if no formatter is available
			lsp_format = "fallback",
		},
	},
}
