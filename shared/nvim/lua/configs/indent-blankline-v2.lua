#!/usr/bin/env lua

--
-- nvim/lua/configs/indent-blankline-v2.lua
--

-- https://github.com/kiyoon/indent-blankline-v2.nvim

require("indent_blankline").setup({
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
})
