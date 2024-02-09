#!/usr/bin/env lua

--
-- nvim/init.lua
--

-- vim settings
require("settings")

-- autocommands and functions
require("autocmds")

-- keybinds
require("keybinds")

-- filetypes
require("filetypes")

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
