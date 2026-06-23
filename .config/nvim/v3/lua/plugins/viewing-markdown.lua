vim.pack.add({
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("^v3.16.0") },
})

require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/Documents/second-brain",
		},
	},

	note_id_func = require("obsidian.builtin").title_id,

	-- this disables frontmatter entirely on new notes
	-- note = {
	-- 	template = vim.NIL,
	-- },
	--
	sync = {
		enabled = true,
	},

	daily_notes = {
		folder = "dailies",
	},

	templates = {
		folder = "templates",
		customizations = {
			task = {
				notes_subdir = "tasks",
			},
			["shared-expense"] = {
				notes_subdir = "home/shared-expenses",
				note_id_func = function(title)
					if title == nil then
						return nil
					end

					local util = require("obsidian.util")

					local date = util.format_date(os.time(), Obsidian.opts.templates.date_format)

					local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					return date .. "-" .. name
				end,
			},
		},
	},
})
