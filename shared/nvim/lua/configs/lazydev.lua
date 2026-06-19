#!/usr/bin/env lua

--
-- nvim/lua/configs/lazydev.lua
--

-- https://github.com/folke/lazydev.nvim

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
