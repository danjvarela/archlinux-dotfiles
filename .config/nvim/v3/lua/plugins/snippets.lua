vim.pack.add({
	{ src = "https://github.com/rafamadriz/friendly-snippets", version = "main" },
	{ src = "https://github.com/nvim-mini/mini.snippets", version = vim.version.range("^v0.17.0") },
})

local gen_loader = require("mini.snippets").gen_loader

require("mini.snippets").setup({
	snippets = {
		-- Load custom file with global snippets first (adjust for Windows)
		gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),

		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		gen_loader.from_lang(),
	},
})
