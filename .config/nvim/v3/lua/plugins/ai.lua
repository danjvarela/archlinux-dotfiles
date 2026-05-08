vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "mcphub.nvim" and (kind == "install" or kind == "update") then
			local path = ev.data.path
			vim.system({ "nvim", "--headless", "-l", path .. "/bundled_build.lua" }, { text = true }, function(result)
				if result.code ~= 0 then
					vim.schedule(function()
						vim.notify("mcphub.nvim build failed:\n" .. result.stderr, vim.log.levels.ERROR)
					end)
				end
			end)
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	-- { src = "https://github.com/ravitemer/mcphub.nvim", version = vim.version.range("^v6.2.0") },
	{ src = "https://www.github.com/olimorris/codecompanion.nvim", version = vim.version.range("^19.7.0") },
	"https://github.com/bahaaza/mcphub.nvim",
})

require("mcphub").setup({
	workspace = {
		enabled = true, -- Default: true
		look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
		reload_on_dir_changed = true, -- Auto-switch on directory change
		port_range = { min = 40000, max = 41000 }, -- Port range for workspace hubs
		get_port = nil, -- Optional function for custom port assignment
	},
	use_bundled_binary = true,
})

require("copilot").setup({})

require("codecompanion").setup({
	rules = {
		default = {
			description = "Collection of common files for all projects",
			files = {
				".clinerules",
				".cursorrules",
				".goosehints",
				".rules",
				".windsurfrules",
				".github/copilot-instructions.md",
				"AGENT.md",
				"AGENTS.md",
				{ path = "CLAUDE.md", parser = "claude" },
				{ path = "CLAUDE.local.md", parser = "claude" },
				{ path = "~/.claude/CLAUDE.md", parser = "claude" },
			},
			is_preset = true,
		},
		opts = {
			chat = {
				autoload = "default",
				enabled = true,
			},
		},
	},
	display = {
		action_palette = {
			opts = {
				show_preset_prompts = false,
			},
		},
		chat = {
			icons = {
				chat_context = "📎️", -- You can also apply an icon to the fold
			},
			fold_context = true,
		},
	},
	prompt_library = {
		markdown = {
			dirs = {
				vim.fn.stdpath("config") .. "/prompts",
			},
		},
	},
	extensions = {
		mcphub = {
			callback = "mcphub.extensions.codecompanion",
			opts = {
				-- MCP Tools
				make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
				show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
				add_mcp_prefix_to_tool_names = true, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
				show_result_in_chat = true, -- Show tool results directly in chat buffer
				format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
				-- MCP Resources
				make_vars = true, -- Convert MCP resources to #variables for prompts
				-- MCP Prompts
				make_slash_commands = true, -- Add MCP prompts as /slash commands
			},
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
