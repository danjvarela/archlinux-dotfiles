vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.cmd("TSUpdate")
		end
	end,
})

--- language parser
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
local treesitter = require("nvim-treesitter")
treesitter.install({
	"astro",
	"bash",
	"c_sharp",
	"css",
	"dockerfile",
	"embedded_template",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"html",
	"http",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"lua",
	"markdown",
	"prisma",
	"scss",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"astro",
		"sh",
		"cs",
		"css",
		"dockerfile",
		"eruby",
		"ejs",
		"gitconfig",
		"gitrebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"html",
		"http",
		"javascript",
		"json",
		"json5",
		"lua",
		"markdown",
		"prisma",
		"scss",
		"sql",
		"svelte",
		"toml",
		"typescriptreact",
		"typescript",
		"yaml",
	},
	callback = function()
		vim.treesitter.start()

		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
