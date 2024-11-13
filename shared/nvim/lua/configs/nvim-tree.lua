#!/usr/bin/env lua

--
-- nvim/lua/configs/nvim-tree.lua
--

-- https://github.com/kyazdani42/nvim-tree.lua


-- disable neovim's built-in file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true
  },
  renderer = {
    group_empty = true
  },
  filters = {
    dotfiles = false
  }
})

vim.api.nvim_create_user_command("Tree", "NvimTreeToggle", { })
