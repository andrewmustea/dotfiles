#!/usr/bin/env lua

--
-- nvim/lua/config/vgit.lua
--

-- https://github.com/tanvirtin/vgit.nvim

require("vgit").setup({
  settings = {
    hls = {
      GitComment = {
        gui = nil,
        fg = "#505050",
        bg = nil,
        sp = nil,
        override = true
      }
    },
    scene = {
      diff_preference = "split"
    }
  }
})
