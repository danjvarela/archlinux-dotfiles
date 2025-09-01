-- visual settings
vim.opt.number = true -- enable line numbers
vim.opt.termguicolors = true -- enable 24-bit color support
vim.opt.signcolumn = "yes" -- always show the signcolumn
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.laststatus = 3 -- always show status line and only on the last window

-- cursor settings
vim.opt.guicursor = "" -- fat cursor no matter the mode

-- clipboard settings
vim.opt.clipboard:append("unnamed,unnamedplus") -- use system clipboard

-- searching settings
vim.opt.ignorecase = true -- when searching, ignore the case
vim.opt.smartcase = true -- when searching, if match exact case if the pattern contains uppercase letters

-- indentation settings
vim.opt.tabstop = 2 -- number of spaces a <Tab> in the file counts for
vim.opt.shiftwidth = 2 -- number of spaces for each (auto)indent step
vim.opt.softtabstop = 2 -- number of spaces the <Tab> key inserts
vim.opt.expandtab = true -- expand tabs to spaces

-- file settings
vim.opt.backup = false -- do not create backups
vim.opt.writebackup = false -- do not create backups
vim.opt.swapfile = false -- do not create a swap file
vim.opt.undofile = true -- persist undo history
vim.opt.autoread = true -- auto reload changes made to a file by another program outside nvim
vim.opt.confirm = true -- prompt before closing

-- fold settings
vim.opt.foldmethod = "expr" -- use foldexpr for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

-- split settings
vim.opt.splitbelow = true -- horizontal splits go below by default
vim.opt.splitright = true -- vertical splits go right by default

-- command line settings
vim.opt.path:append("**") -- search within subdirectories, usefule for :find
vim.opt.wildmenu = true -- enhanced command line completion
vim.opt.wildmode = "longest:full,full" -- autocomplete behavior when typing command

-- completion settings
vim.opt.completeopt = "menu,menuone,noinsert,fuzzy,popup"
vim.opt.pumheight = 10

-- global variables
vim.g.mapleader = " "
