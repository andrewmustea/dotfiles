#!/usr/bin/env lua

--
-- nvim/lua/config/nvim-tree.lua
--

-- https://github.com/kyazdani42/nvim-tree.lua

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" }
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  }
})

vim.api.nvim_create_user_command("Tree", "NvimTreeToggle", { })
