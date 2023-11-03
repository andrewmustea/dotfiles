#!/usr/bin/env lua

--
-- nvim/lua/config/nvim-hlslens.lua
--

-- https://github.com/kevinhwang91/nvim-hlslens

local map = vim.keymap.set

require("hlslens").setup({
  build_position_cb = function(plist, _, _, _)
    require("scrollbar.handlers.search").handler.show(plist.start_pos)
  end,
})

require("scrollbar").setup({
  marks = {
    Search = { color = "#8030e0"}
  },
  handlers = {
    search = true
  }
})

local kopts = { noremap = true, silent = true }

map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "<Leader>l", ":noh<CR>", kopts)
