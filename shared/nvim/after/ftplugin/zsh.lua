#!/usr/bin/env lua

--
-- nvim/after/ftplugin/zsh.lua
--

-- no native zsh parser; bash parser is registered for zsh in filetypes.lua
vim.treesitter.start()
