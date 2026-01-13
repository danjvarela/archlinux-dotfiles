return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons", "folke/snacks.nvim" },
	branch = "stable",
	lazy = false,
	opts = {
		hooks = {
			on_rename = function(src, dst)
				Snacks.rename.on_rename_file(src, dst)
				print("RENAMED: " .. src .. " > " .. dst) -- You can do anything whenever an item Renamed
			end,
		},
	},
	keys = function()
		return {
			{ "<leader>fm", "<Cmd>Fyler<Cr>", desc = "Open Fyler View" },
		}
	end,
}
