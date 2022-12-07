-- nvim-scrollbar
--

local api = vim.api

require("scrollbar").setup {
  handle = {
    text = " ",
    color = "#202020",
    cterm = nil,
    highlight = "CursorColumn",
    hide_if_all_visible = true,
  },
  marks = {
    Cursor = {
        text = "•",
        priority = 0,
        color = "#888888",
        cterm = nil,
        highlight = "Normal"
    }
  },
  handlers = {
    cursor = true,
    diagnostic = true,
    gitsigns = true,
    handle = true,
    search = false
  }
}

api.nvim_create_autocmd("CmdlineLeave", {
  group = api.nvim_create_augroup("scrollbar_search_hide", { clear = true }),
  callback =
    function()
      return require('scrollbar.handlers.search').handler.hide()
    end
  }
)

