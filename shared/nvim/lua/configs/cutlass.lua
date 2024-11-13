#!/usr/bin/env lua

--
-- nvim/lua/configs/cutlass.lua
--

-- https://github.com/gbprod/cutlass.nvim

require("cutlass").setup({
  exclude = { "nd", "xd", "nD", "xD" }
})
