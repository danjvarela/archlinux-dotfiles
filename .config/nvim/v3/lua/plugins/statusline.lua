vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = vim.o.laststatus == 3,
	},
	sections = {
		-- lualine_x = {
		-- 	require("copilot_agent").statusline_mode, -- [ask] / [plan] / [agent] / [autopilot]
		-- 	require("copilot_agent").statusline_model, -- claude-sonnet-4.6 / default
		-- 	require("copilot_agent").statusline_busy, -- ✅ready / ⏳working / 📝sync / 🧩2 tasks / ❓input
		-- 	require("copilot_agent").statusline_permission, -- 🔐interactive / ✅approve-all / 🤖autopilot
		-- 	require("copilot_agent").statusline_attachments, -- 📎3 (when attachments pending)
		-- 	require("copilot_agent").statusline_tool, -- 🔧 read_file (active tool)
		-- 	require("copilot_agent").statusline_intent, -- current agent intent
		-- 	require("copilot_agent").statusline_context, -- 12k/200k plus quota remaining when available
		-- },
	},
})
