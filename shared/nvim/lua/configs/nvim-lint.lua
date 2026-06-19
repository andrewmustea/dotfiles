#!/usr/bin/env lua

--
-- nvim/lua/configs/nvim-lint.lua
--

-- https://github.com/mfussenegger/nvim-lint

require("lint").linters_by_ft = {
  gitcommit = { "gitlint" },
  markdown = { "markdownlint" },
  yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
