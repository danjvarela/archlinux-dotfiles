vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.pick",
		version = "main",
	},
})

require("mini.pick").setup({})

local map = vim.keymap.set

map({ "n", "v" }, "<leader>ff", function()
	MiniPick.builtin.files({
    tool = "git"
  })
end, { desc = "Find files" })

map({ "n", "v" }, "<leader>fw", function()
	MiniPick.builtin.grep_live()
end, { desc = "Find word" })

map({ "n", "v" }, "<leader>fh", function()
	MiniPick.builtin.help()
end, { desc = "Find help" })

map({ "n", "v" }, "<leader>fr", function()
	MiniPick.builtin.resume()
end, { desc = "Resume last picker" })

map({ "n", "v" }, "<leader>fd", function()
	MiniExtra.pickers.diagnostic({ scope = "current" })
end, { desc = "Find diagnostics on current buffer" })

map({ "n", "v" }, "<leader>fD", function()
	MiniExtra.pickers.diagnostic({ scope = "all" })
end, { desc = "Find all diagnostics" })

map({ "n", "v" }, "<leader>gc", function()
	MiniExtra.pickers.git_hunks({ scope = "unstaged" })
end, { desc = "Find git changes" })

map({ "n", "v" }, "<leader>fk", function()
	MiniExtra.pickers.keymaps()
end, { desc = "Find keymaps" })

map({ "n", "v" }, "<leader>fs", function()
	MiniExtra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "Find document symbol" })
