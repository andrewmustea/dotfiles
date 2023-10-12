-- yanky.nvim
--

local map = vim.keymap.set

require("yanky").setup {
  ring = {
    history_length = 100,
    storage = "shada",
    sync_with_numbered_registers = true,
    cancel_event = "update"
  },
  system_clipboard = {
    sync_with_ring = true
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500
  },
  preserve_cursor_position = {
    enabled = true
  },
  picker = {
    select = {
      action = nil -- nil to use default put action
    },
    telescope = {
      mappings = nil -- nil to use default mappings
    }
  }
}

map("x", "p", function() require('substitute').visual() end, { noremap = true })
map("x", "P", function() require('substitute').visual() end, { noremap = true })

map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

map("n", "<c-n>", "<Plug>(YankyCycleForward)")
map("n", "<c-p>", "<Plug>(YankyCycleBackward)")

map("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
map("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
map("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
map("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

map("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
map("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
map("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
map("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

map("n", "=p", "<Plug>(YankyPutAfterFilter)")
map("n", "=P", "<Plug>(YankyPutBeforeFilter)")

