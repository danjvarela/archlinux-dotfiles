vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "avante.nvim" and (kind == "install" or kind == "update") then
			local path = ev.data.path
			vim.system({ "make", "-C", path }, { text = true }, function(result)
				if result.code ~= 0 then
					vim.schedule(function()
						vim.notify("avante.nvim make failed:\n" .. result.stderr, vim.log.levels.ERROR)
					end)
				end
			end)
		end
	end,
})

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/MunifTanjim/nui.nvim", version = "0.4.0" },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/ravitemer/mcphub.nvim", version = "v6.2.0" },
	{ src = "https://github.com/yetone/avante.nvim", version = "v0.0.27" },
})

require("mcphub").setup({
	workspace = {
		enabled = true,
	},
})

require("copilot").setup({})

_G.avante_omnifunc = function(findstart, base)
	if findstart == 1 then
		local line = vim.api.nvim_get_current_line()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local start = line:sub(1, col):find("[@/#]%w*$")
		return start and (start - 1) or -3
	end

	local trigger = base:sub(1, 1)
	local word = base:sub(2)
	local Utils = require("avante.utils")
	local items = {}

	local function matches(name)
		return word == "" or name:sub(1, #word) == word
	end

	if trigger == "@" then
		for _, m in ipairs(Utils.get_chat_mentions()) do
			if matches(m.command) then
				table.insert(items, {
					word = "@" .. m.command .. " ",
					abbr = "@" .. m.command,
					menu = m.details,
					user_data = { type = "mention", command = m.command },
				})
			end
		end
	elseif trigger == "/" then
		for _, c in ipairs(Utils.get_commands()) do
			if matches(c.name) then
				table.insert(items, {
					word = "/" .. c.name,
					abbr = "/" .. c.name,
					menu = c.description or "",
					user_data = { type = "command", name = c.name },
				})
			end
		end
	elseif trigger == "#" then
		for _, s in ipairs(Utils.get_shortcuts()) do
			if matches(s.name) then
				table.insert(items, {
					word = "#" .. s.name,
					abbr = "#" .. s.name,
					menu = s.details or s.description or "",
					user_data = { type = "shortcut", name = s.name },
				})
			end
		end
	end

	return items
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "AvanteInput",
	callback = function(ev)
		local bufnr = ev.buf
		vim.bo[bufnr].omnifunc = "v:lua.avante_omnifunc"

		for _, ch in ipairs({ "@", "/", "#" }) do
			vim.keymap.set("i", ch, ch .. "<C-x><C-o>", { buffer = bufnr, noremap = true, silent = true })
		end

		vim.api.nvim_create_autocmd("CompleteDone", {
			buffer = bufnr,
			callback = function()
				local item = vim.v.completed_item
				if not item or type(item.user_data) ~= "table" then
					return
				end
				local data = item.user_data
				local sidebar = require("avante").get()
				if not sidebar then
					return
				end

				if data.type == "mention" then
					local mentions = require("avante.utils").get_chat_mentions()
					local mention = vim.iter(mentions):find(function(m)
						return m.command == data.command
					end)
					if mention and type(mention.callback) == "function" then
						local row, col = unpack(vim.api.nvim_win_get_cursor(0))
						local line = vim.api.nvim_get_current_line()
						local new_line = line:gsub(vim.pesc(item.word) .. "%s*", "")
						vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
						vim.api.nvim_win_set_cursor(0, { row, math.min(col, #new_line) })
						mention.callback(sidebar)
					end
				elseif data.type == "command" then
					local commands = require("avante.utils").get_commands()
					local cmd = vim.iter(commands):find(function(c)
						return c.name == data.name
					end)
					if cmd then
						cmd.callback(sidebar, nil, function()
							local ibufnr = sidebar.containers.input.bufnr
							vim.defer_fn(function()
								if vim.api.nvim_buf_is_valid(ibufnr) then
									local content = table.concat(vim.api.nvim_buf_get_lines(ibufnr, 0, -1, false), "\n")
									vim.api.nvim_buf_set_lines(
										ibufnr,
										0,
										-1,
										false,
										vim.split(content:gsub(vim.pesc(item.word), ""), "\n")
									)
								end
							end, 100)
						end)
					end
				end
				-- shortcuts: sidebar handle_submit handles #shortcut substitution
			end,
		})
	end,
})

require("avante").setup({
	mode = "legacy",
	instructions_file = "AGENTS.md",
	input = {
		provider = "native",
	},
	provider = "copilot",
	providers = {
		copilot = {
			model = "claude-sonnet-4.6",
		},
	},
	system_prompt = function()
		local hub = require("mcphub").get_hub_instance()
		return hub and hub:get_active_servers_prompt() or ""
	end,
	-- Using function prevents requiring mcphub before it's loaded
	custom_tools = function()
		return {
			require("mcphub.extensions.avante").mcp_tool(),
		}
	end,
	behavior = {
		auto_set_keymaps = false,
	},
	-- available already in mcphub
	disabled_tools = {
		"list_files", -- Built-in file operations
		"search_files",
		"read_file",
		"create_file",
		"rename_file",
		"delete_file",
		"create_dir",
		"rename_dir",
		"delete_dir",
		"bash", -- Built-in terminal access
	},
})
