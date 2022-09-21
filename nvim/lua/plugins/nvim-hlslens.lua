-- nvim-hlslens
--

local api = vim.api
local kopts = { noremap = true, silent = true }

require("hlslens").setup({
  build_position_cb = function(plist, _, _, _)
    require("scrollbar.handlers.search").handler.show(plist.start_pos)
  end,
})

api.nvim_set_keymap("n", "n",
  [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]],
  kopts)
api.nvim_set_keymap("n", "N",
  [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]],
  kopts)
api.nvim_set_keymap("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]], kopts)
api.nvim_set_keymap("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]], kopts)
api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]], kopts)
api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]], kopts)

api.nvim_set_keymap("n", "<Leader>l", ":noh<CR>", kopts)

