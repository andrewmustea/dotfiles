#!/usr/bin/env lua

--
-- nvim/lua/autocmds.lua
--

local bo  = vim.bo
local fn  = vim.fn
local api = vim.api

-- abbreviation to split buffers vertically
vim.cmd.cabbrev("vsb vert sb")

-- quit commands
api.nvim_create_user_command("Q", "q", { })
api.nvim_create_user_command("WQ", "wq", { })
api.nvim_create_user_command("Wq", "wq", { })
api.nvim_create_user_command("QA", "qa", { })
api.nvim_create_user_command("Qa", "qa", { })
api.nvim_create_user_command("Wqa", "wqa", { })
api.nvim_create_user_command("WQa", "wqa", { })
api.nvim_create_user_command("WQA", "wqa", { })

-- show syntax highlights
api.nvim_create_user_command("ShowHighlights", "silent runtime syntax/hitest.vim", { bang = true })

-- split helpfiles vertically to the left
api.nvim_create_autocmd(
  "BufEnter",
  { group = api.nvim_create_augroup("vert_help", { clear = true }),
    pattern = "*.txt",
    callback = function()
      if bo.buftype == "help" then
        api.nvim_command("wincmd H")
      end
    end
  }
)

-- remove trailing whitespace on save
api.nvim_create_autocmd(
  "BufWritePre",
  { group = api.nvim_create_augroup("strip_whitespace", { clear = true }),
    callback = function()
      local ignore_files = { ruby = true, javascript = true, perl = true, diff = true }
      if ignore_files[bo.filetype] ~= nil then
        return
      end
      local save_cursor = fn.winsaveview()
      api.nvim_command("%s/\\s\\+$//e")
      api.nvim_call_function("winrestview", { save_cursor })
    end
  }
)

-- reset cursor to a vertical line when using iterm2
if vim.env.TERM_PROGRAM == "iTerm.app" then
  api.nvim_create_autocmd(
    "VimLeave",
    { pattern = "*",
      command = "set guicursor=a:ver25"
    }
  )
end
