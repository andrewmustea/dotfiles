-- indent-blankline.nvim
--

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
  space_char_blankline = " "
}

