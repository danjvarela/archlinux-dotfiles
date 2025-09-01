return {
	"nvim-mini/mini.files",
	version = "*",
	opts = {
		options = {
			-- use trash stored at mini.files/trash
			permanent_delete = false,
			-- snacks file explorer is the default one
			use_as_default_explorer = false,
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		local minifiles_toggle = function(...)
			if not MiniFiles.close() then
				MiniFiles.open(...)
			end
		end

    -- stylua: ignore start
    vim.keymap.set({ 'n', 'v' }, '<leader>fm', function() minifiles_toggle(vim.api.nvim_buf_get_name(0), true) end, { desc = "Open mini.files (directory of current file)" })
    vim.keymap.set({ 'n', 'v' }, '<leader>fM', function() minifiles_toggle(vim.uv.cwd(), true) end, { desc = "Open mini.files (cwd)" })
		-- stylua: ignore end
	end,
}
