-- copilot.vim
--

vim.g.copilot_no_tab_map = true

vim.keymap.set(
  "i",
  "<M-j>",
  function()
    return vim.fn["copilot#Accept"]("")
  end,
  { silent = true, expr = true }
)

