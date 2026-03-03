vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
require("render-markdown").setup({
	enabled = false,
	preset = "obsidian",
  anti_conceal = {
    enabled = false
  }
})

local render_markdown = require("render-markdown")

vim.keymap.set("n", "<leader>mm", render_markdown.buf_toggle, { desc = "View markdown" })
vim.keymap.set("n", "<leader>mp", render_markdown.preview, { desc = "View markdown (Split)" })
