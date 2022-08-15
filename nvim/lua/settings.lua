-- nvim settings
--
local o   = vim.o

-- highlighting
o.syntax = true
o.termguicolors = true

-- turn off all sounds
o.belloff = true

-- command line history size
o.history = 1000

-- set line and column numbers
o.number = true
o.ruler = true

-- show commands but not mode on last line
o.showcmd = true
o.showmode = false

-- show cursorline
o.cursorline = true

-- wrap text
o.wrap = true

-- highlight previous and incremental searches
o.hlsearch = true
o.incsearch = true

-- split buffers better
o.splitright = true
o.splitbelow = true

-- show matching bracket
o.showmatch = true

-- indenting
o.autoindent = true
o.cindent = true
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.smarttab = true
o.softtabstop = -1
o.tabstop = 4

-- case insensitive search unless /C or capital in search
o.ignorecase = true
o.smartcase = true

-- wrap search at end or beginning of file
o.wrapscan = true

-- diff optins
o.diffopt = "internal,filler,closeoff,vertical,hiddenoff"

-- number of lines to keep above and below cursor
o.scrolloff = 8

-- save undo history in separate file
o.undofile = true

-- do not save when switching buffers
o.hidden = true

-- python3 provider
vim.g.python3_host_prog = "/usr/bin/python3"
