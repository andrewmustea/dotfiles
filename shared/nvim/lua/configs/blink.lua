#!/usr/bin/env lua

--
-- nvim/lua/configs/blink.lua
--

-- https://github.com/saghen/blink.cmp

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-CR>"] = { "accept", "fallback" },
  },
  cmdline = { enabled = false },
  appearance = {
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  completion = {
    list = {
      selection = { preselect = false },
    },
  },
  snippets = { preset = "luasnip" },
  signature = { enabled = true },
})
