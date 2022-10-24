-- autocmd.lua
--

local bo  = vim.bo
local fn  = vim.fn
local api = vim.api

-- abbreviation to split buffers vertically
api.nvim_command("cabbrev vsb vert sb")

-- map accidental shift when quitting
api.nvim_create_user_command("Q", "q", { })
api.nvim_create_user_command("WQ", "wq", { })
api.nvim_create_user_command("Wq", "wq", { })
api.nvim_create_user_command("QA", "qa", { })
api.nvim_create_user_command("Qa", "qa", { })
api.nvim_create_user_command("Wqa", "wqa", { })
api.nvim_create_user_command("WQa", "wqa", { })
api.nvim_create_user_command("WQA", "wqa", { })

-- show highlights and under cursor highlight group
api.nvim_create_user_command("ShowHighlights", "silent runtime syntax/hitest.vim", { bang = true })
api.nvim_create_user_command("HighlightGroup", "echo synIDattr(synID(line('.'),col('.'),1),'name')", { bang = true })

-- split helpfiles vertically to the left
api.nvim_create_autocmd("BufEnter", {
  group = api.nvim_create_augroup("vert_help", { clear = true }),
  pattern = { "*.txt" },
  callback =
    function()
      if bo.buftype == "help" then
        api.nvim_command("wincmd H")
      end
    end
})

-- remove trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
  group = api.nvim_create_augroup("strip_whitespace", { clear = true }),
  callback =
    function()
      local ignore_files = { ruby = true, javascript = true, perl = true, diff = true }
      if ignore_files[bo.filetype] ~= nil then
        return
      end
      local save_cursor = fn.winsaveview()
      api.nvim_command("%s/\\s\\+$//e")
      api.nvim_call_function("winrestview", { save_cursor })
    end
})

-- set lua to shiftwidth 2 by default
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = api.nvim_create_augroup("lua_shiftwidth", { clear = true }),
  pattern = "*.lua",
  callback =
    function()
      vim.opt_local.shiftwidth = 2
    end
})

