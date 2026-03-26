vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.move",
		version = "main",
	},
})

require("mini.move").setup({
	mappings = {
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
		left = "<M-S-h>",
		right = "<M-S-l>",
		down = "<M-S-j>",
		up = "<M-S-k>",

		-- Move current line in Normal mode
		line_left = "<M-S-h>",
		line_right = "<M-S-l>",
		line_down = "<M-S-j>",
		line_up = "<M-S-k>",
	},
})
