return {
	diff = function()
		local default_branch = vim.system(
			{ "git", "remote", "show", "origin" },
			{ text = true }
		):wait().stdout:match("HEAD branch: (%S+)")
		local merge_base = vim.system(
			{ "git", "merge-base", "HEAD", "origin/" .. default_branch },
			{ text = true }
		):wait().stdout:gsub("%s+", "")
		local log = vim.system(
			{ "git", "log", "--oneline", "--no-merges", merge_base .. "..HEAD" },
			{ text = true }
		):wait().stdout
		local diff = vim.system(
			{ "git", "diff", "--no-ext-diff", merge_base .. "..HEAD" },
			{ text = true }
		):wait().stdout
		return log .. "\n" .. diff
	end,
}
