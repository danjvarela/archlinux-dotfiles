local M = {}

function M.get_typescript_server_path(root_dir)
	local project_roots = vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })
	for _, project_root in ipairs(project_roots) do
		-- Standard npm/yarn layout: node_modules/typescript
		local typescript_path = project_root .. "/typescript"
		local stat = vim.loop.fs_stat(typescript_path)
		if stat and stat.type == "directory" then
			return typescript_path .. "/lib"
		end

		-- pnpm virtual store layout: node_modules/.pnpm/typescript@<version>/node_modules/typescript
		local pnpm_store = project_root .. "/.pnpm"
		local pnpm_stat = vim.loop.fs_stat(pnpm_store)
		if pnpm_stat and pnpm_stat.type == "directory" then
			local handle = vim.loop.fs_scandir(pnpm_store)
			if handle then
				while true do
					local name, ftype = vim.loop.fs_scandir_next(handle)
					if not name then break end
					if (ftype == "directory" or ftype == "link") and name:match("^typescript@") then
						local candidate = pnpm_store .. "/" .. name .. "/node_modules/typescript/lib"
						if vim.loop.fs_stat(candidate) then
							return candidate
						end
					end
				end
			end
		end
	end
	return ""
end

function M.insert_package_json(root_files, field, fname)
	return M.root_markers_with_field(root_files, { "package.json", "package.json5" }, field, fname)
end

--- Appends `new_names` to `root_files` if `field` is found in any such file in any ancestor of `fname`.
---
--- NOTE: this does a "breadth-first" search, so is broken for multi-project workspaces:
--- https://github.com/neovim/nvim-lspconfig/issues/3818#issuecomment-2848836794
---
--- @param root_files string[] List of root-marker files to append to.
--- @param new_names string[] Potential root-marker filenames (e.g. `{ 'package.json', 'package.json5' }`) to inspect for the given `field`.
--- @param field string Field to search for in the given `new_names` files.
--- @param fname string Full path of the current buffer name to start searching upwards from.
function M.root_markers_with_field(root_files, new_names, field, fname)
	local path = vim.fn.fnamemodify(fname, ":h")
	local found = vim.fs.find(new_names, { path = path, upward = true, type = "file" })

	for _, f in ipairs(found or {}) do
		-- Match the given `field`.
		for line in io.lines(f) do
			if line:find(field) then
				root_files[#root_files + 1] = vim.fs.basename(f)
				break
			end
		end
	end

	return root_files
end

return M
