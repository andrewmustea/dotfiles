#!/usr/bin/env lua

--
-- nvim/lua/config/indent-blankline.lua
--

-- https://github.com/lukas-reineke/indent-blankline.nvim

require("ibl").setup({
  debounce = 100,
  scope = { highlight = "Statement" }
})
