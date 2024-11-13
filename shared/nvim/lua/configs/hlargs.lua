#!/usr/bin/env lua

--
-- nvim/lua/configs/hlargs.lua
--

-- https://github.com/m-demare/hlargs.nvim

local blue = "#0078c8"

require("hlargs").setup({
  color = blue,
  highlight = { },
  excluded_filetypes = { },
  -- disable = function(lang, bufnr) -- If changed, `excluded_filetypes` will be ignored
  --   return vim.tbl_contains(vim.opts.excluded_filetypes, lang)
  -- end,
  paint_arg_declarations = true,
  paint_arg_usages = true,
  paint_catch_blocks = {
    declarations = false,
    usages = false
  },
  extras = {
    named_parameters = false,
  },
  hl_priority = 10000,
  excluded_argnames = {
    declarations = { },
    usages = {
      python = { "self", "cls" },
      lua = { "self" }
    }
  },
  performance = {
    parse_delay = 1,
    slow_parse_delay = 50,
    max_iterations = 400,
    max_concurrent_partial_parses = 30,
    debounce = {
      partial_parse = 3,
      partial_insert_mode = 100,
      total_parse = 700,
      slow_parse = 5000
    }
  }
})
