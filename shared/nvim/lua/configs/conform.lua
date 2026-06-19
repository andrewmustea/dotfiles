#!/usr/bin/env lua

--
-- nvim/lua/configs/conform.lua
--

-- https://github.com/stevearc/conform.nvim

require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    css = { "prettier" },
    go = { "gofmt", "golines" },
    html = { "prettier" },
    java = { "clang_format" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "ruff" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    toml = { "taplo" },
    typescript = { "prettier" },
    yaml = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci", "-bn" },
    },
  },
})
