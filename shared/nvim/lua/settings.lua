#!/usr/bin/env lua

--
-- nvim/lua/settings.lua
--


local g = vim.g
local o = vim.o
local wo = vim.wo


-- session settings
--------------------

-- mouse support
o.mouse = "nv"

-- update time for swap file write and CursorHold
o.updatetime = 300

-- turn off all sounds
o.belloff = "all"

-- command line history size
o.history = 10000

-- save undo history after closing buffer
if g.vscode == nil then
  o.undofile = true
end


-- ui
--------------------

-- enable snytax highlighting
o.syntax = "off"
o.termguicolors = true

-- show line and column numbers
o.number = true
o.ruler = true

-- last line should only show commands
o.showcmd = true
o.showmode = false

-- signcolumn
wo.signcolumn = "yes"

-- show cursorline
o.cursorline = true

-- wrap text
o.wrap = true

-- number of lines to keep above and below cursor
o.scrolloff = 8

-- show matching bracket
o.showmatch = true

-- indenting
o.autoindent = true
o.cindent = true
o.expandtab = true
o.shiftwidth = 0
o.smarttab = true
o.softtabstop = -1
o.tabstop = 2

-- diff options
o.diffopt = "internal,filler,closeoff,vertical,hiddenoff"


-- buffers
--------------------

-- prefer splitting buffers to the right
o.splitright = true

-- don't save when switching buffers
o.hidden = true


-- search
--------------------

-- case insensitive search unless /C or capital in search
o.ignorecase = true
o.smartcase = true

-- highlight previous and incremental matches during search
o.hlsearch = true
o.incsearch = true

-- wrap search at beginning or end of file
o.wrapscan = true


-- providers
--------------------

-- clipboard
o.clipboard = "unnamedplus"

-- python3
g.python3_host_prog = "/usr/bin/python3"
