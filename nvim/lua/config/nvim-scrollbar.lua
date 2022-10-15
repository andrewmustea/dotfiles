-- nvim-scrollbar
--

local api = vim.api

require("scrollbar").setup({
  api.nvim_create_autocmd("CmdlineLeave", {
    group = api.nvim_create_augroup("scrollbar_search_hide", { clear = true }),
    callback =
      function()
        api.nvim_command("lua require('scrollbar.handlers.search').handler.hide()")
      end
  })
})

