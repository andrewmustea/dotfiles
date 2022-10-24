-- nvim-hlslens
--

local map = vim.keymap.set
local kopts = { noremap = true, silent = true }

require("hlslens").setup({
  build_position_cb = function(plist, _, _, _)
    require("scrollbar.handlers.search").handler.show(plist.start_pos)
  end,
})

map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", kopts)
map("n", "<Leader>l", ":noh<CR>", kopts)

