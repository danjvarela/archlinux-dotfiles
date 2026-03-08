vim.pack.add({
	"https://github.com/JezerM/oil-lsp-diagnostics.nvim",
	{
		src = "https://github.com/malewicz1337/oil-git.nvim",
		version = vim.version.range("^v1.0.1"),
	},
	{
		src = "https://github.com/stevearc/oil.nvim",
		version = vim.version.range("^v2.15.0"),
	},
})

local detail = false
local oil = require("oil")
oil.setup({
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
	},
	win_options = {
		signcolumn = "yes:2",
	},
	git = {
		mv = function()
			return true
		end,
		rm = function()
			return true
		end,
	},
	lsp_file_methods = {
		-- Enable or disable LSP file operations
		enabled = true,
		-- Time to wait for LSP file operations to complete before skipping
		timeout_ms = 1000,
		-- Set to true to autosave buffers that are updated with LSP willRenameFiles
		-- Set to "unmodified" to only save unmodified buffers
		autosave_changes = true,
	},
	watch_for_changes = false,
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["gd"] = {
			desc = "Toggle file detail view",
			callback = function()
				detail = not detail
				if detail then
					require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
				else
					require("oil").set_columns({ "icon" })
				end
			end,
		},
	},
})

require("oil-git").setup({
	symbol_position = "signcolumn",
})
require("oil-lsp-diagnostics").setup()

vim.keymap.set({ "n", "v" }, "<leader>e", oil.toggle_float, { desc = "Open file explorer" })
