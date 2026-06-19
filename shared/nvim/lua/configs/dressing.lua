#!/usr/bin/env lua

--
-- nvim/lua/configs/dressing.lua
--

-- https://github.com/stevearc/dressing.nvim

require("dressing").setup({
  input = {
    default_prompt = "Input:",
    border = "rounded",
    relative = "cursor",
    prefer_width = 40,
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },
    win_options = {
      winblend = 10,
      wrap = false,
      list = true,
      listchars = "precedes:…,extends:…",
      sidescrolloff = 0,
    },
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },
  },
  select = {
    backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
    fzf = {
      window = {
        width = 0.5,
        height = 0.4,
      },
    },
    nui = {
      position = "50%",
      relative = "editor",
      border = {
        style = "rounded",
      },
      buf_options = {
        swapfile = false,
        filetype = "DressingSelect",
      },
      win_options = {
        winblend = 10,
      },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 10,
    },
    builtin = {
      border = "rounded",
      relative = "editor",
      win_options = {
        winblend = 10,
        cursorline = true,
        cursorlineopt = "both",
      },
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      max_height = 0.9,
      min_height = { 10, 0.2 },
      mappings = {
        ["<Esc>"] = "Close",
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
      },
    },
  },
})
