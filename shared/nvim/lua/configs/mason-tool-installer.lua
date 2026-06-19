#!/usr/bin/env lua

--
-- nvim/lua/configs/mason-tool-installer.lua
--

-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require("mason-tool-installer").setup({
  ensure_installed = {
    "clang-format",
    "gitlint",
    "golines",
    "isort",
    "markdownlint",
    "prettier",
    "ruff",
    "shfmt",
    "stylua",
    "yamllint",
  },
})
