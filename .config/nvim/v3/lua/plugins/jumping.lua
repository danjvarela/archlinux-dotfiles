vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.jump2d",
    version = "main",
	},
})

require("mini.jump2d").setup({
  view = {
    dim = true
  }
})
