vim.pack.add({ { src = "https://github.com/danjvarela/nvimtasks", version = "v0.2.0" } })
require("nvimtasks").setup()

vim.keymap.set("n", "<leader>tt", function()
	require("nvimtasks").open()
end, { desc = "All Tasks" })
vim.keymap.set("n", "<leader>tw", function()
	require("nvimtasks").open({ options = "rc.data.location=" .. vim.fn.expand("$HOME/.config/taskwarrior/work-data") })
end, { desc = "Work Tasks" })
