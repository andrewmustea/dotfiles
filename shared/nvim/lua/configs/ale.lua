#!/usr/bin/env lua

--
-- nvim/lua/configs/ale.lua
--

-- https://github.com/dense-analysis/ale

local g = vim.g

-- ale settings
g.ale_disable_lsp = 1
g.ale_lint_on_text_changes = 0
g.ale_lint_on_insert_leave = 0
g.ale_lint_on_save = 1
g.ale_lint_on_filetype_changed = 1
g.ale_lint_on_enter = 1

-- linters
-- g.ale_linters_explicit = 1
g.ale_linters = {
  ["lua"] = { },
  ["python"] = { },
  ["sh"] = { }
}
