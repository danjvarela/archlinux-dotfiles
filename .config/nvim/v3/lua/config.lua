local opt = vim.opt

-- visual settings
opt.number = true -- enable line numbers
opt.termguicolors = true -- enable 24-bit color support
opt.signcolumn = "yes" -- always show the signcolumn
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	diff = "╱",
	foldsep = " ",
	eob = " ",
}
opt.laststatus = 3 -- always show status line and only on the last window

-- cursor settings
opt.guicursor = "" -- fat cursor no matter the mode

-- clipboard settings
opt.clipboard:append("unnamed,unnamedplus") -- use system clipboard

-- searching settings
opt.ignorecase = true -- when searching, ignore the case
opt.smartcase = true -- when searching, if match exact case if the pattern contains uppercase letters

-- indentation settings
opt.tabstop = 2 -- number of spaces a <Tab> in the file counts for
opt.shiftwidth = 2 -- number of spaces for each (auto)indent step
opt.softtabstop = 2 -- number of spaces the <Tab> key inserts
opt.expandtab = true -- expand tabs to spaces

-- file settings
opt.backup = false -- do not create backups
opt.writebackup = false -- do not create backups
opt.swapfile = false -- do not create a swap file
opt.undofile = true -- persist undo history
opt.autoread = true -- auto reload changes made to a file by another program outside nvim
opt.confirm = true -- prompt before closing

-- fold settings
opt.foldmethod = "expr" -- use foldexpr for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
opt.foldlevel = 99 -- start with all folds open
opt.foldtext = ""

-- split settings
opt.splitbelow = true -- horizontal splits go below by default
opt.splitright = true -- vertical splits go right by default

-- command line settings
opt.path:append("**") -- search within subdirectories, usefule for :find
opt.wildmenu = true -- enhanced command line completion
opt.wildmode = "longest:full,full" -- autocomplete behavior when typing command
opt.wildoptions = "fuzzy,pum" -- use fuzzy matching to find completion matches

-- completion settings
opt.completeopt = "menu,menuone,noinsert,fuzzy,popup"
opt.pumheight = 10

-- global variables
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
