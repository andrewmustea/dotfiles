#!/usr/bin/env lua

--
-- nvim/after/ftplugin/bash.lua
--

-- vim-endwise checks legacy syntax groups which don't exist with treesitter;
-- clearing this makes it rely on the line pattern match alone
vim.b.endwise_syngroups = ""
