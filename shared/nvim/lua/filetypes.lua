#!/usr/bin/env lua

--
-- nvim/lua/filetypes.lua
--

-- manually set filetypes
vim.filetype.add({
  filename = {
    ["env"] = "sh",
    ["gitconfig"] = "gitconfig",
    ["profile"] = "sh",
    ["vimrc"] = "vim"
  },
  pattern = {
    [".*/git/config"] = "gitconfig",
    [".*bash_profile"] = "sh",
    [".*bashrc"] = "sh",
    [".*luacheckrc"] = "lua",
    [".*requirements.*%.txt"] = "config"
  }
})

-- zsh files should use bash treesitter syntax
vim.treesitter.language.register("bash", "zsh")
