#!/usr/bin/env lua

--
-- nvim/lua/config/indent-o-matic.lua
--

-- https://github.com/Darazaki/indent-o-matic

require("indent-o-matic").setup({
  filetype_ = {
    standard_widths = { 2, 4, 8 },
  },
  filetype_lua = {
    standard_widths = { 2 }
  },
  filetype_markdown = {
    standard_widths = { 2 }
  },
  filetype_python = {
    standard_widths = { 4 }
  }
})
