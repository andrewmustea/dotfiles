-- substitute.lua
--

require("substitute").setup {
  on_substitute = function(event)
    require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
  end
}

vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

vim.keymap.set("n", "<leader>s", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
vim.keymap.set("x", "<leader>s", "<cmd>lua require('substitute.range').visual()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ss", "<cmd>lua require('substitute.range').word()<cr>", { noremap = true })

vim.keymap.set("n", "sx", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
vim.keymap.set("n", "sxx", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
vim.keymap.set("n", "sxc", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })

