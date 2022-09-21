-- autocmd.lua
--
local bo  = vim.bo
local fn  = vim.fn
local api = vim.api

-- map accidental shift when quitting
api.nvim_create_user_command("Q", "q", {})
api.nvim_create_user_command("WQ", "wq", {})
api.nvim_create_user_command("Wq", "wq", {})
api.nvim_create_user_command("QA", "qa", {})
api.nvim_create_user_command("Qa", "qa", {})
api.nvim_create_user_command("Wqa", "wqa", {})
api.nvim_create_user_command("WQa", "wqa", {})
api.nvim_create_user_command("WQA", "wqa", {})

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

-- windows wsl clipboard
if fn.has("wsl") then
  local clip = "/mnt/c/Windows/System32/clip.exe"
  if fn.executable(clip) then
    api.nvim_create_autocmd("TextYankPost", {
      group = api.nvim_create_augroup("wsl_yank", { clear = true }),
      callback =
        function()
          if vim.v.event.operator == "y" then
            api.nvim_call_function("system", { clip, fn.getreg("0") })
          end
        end
    })
  end
end

-- set tabstop for linux kernel c
local function check_expandtab()
    local c_files = { c = true, cpp = true }
    if vim.opt_local.expandtab:get() == false and c_files[bo.filetype] ~= nil then
      vim.opt_local.tabstop = 8
    end
end

local kernel_tabstop = api.nvim_create_augroup("kernel_tabstop", { clear = true })
api.nvim_create_autocmd("VimEnter", {
  group = kernel_tabstop,
  pattern = "*",
  callback = check_expandtab
})
api.nvim_create_autocmd("OptionSet", {
  group = kernel_tabstop,
  pattern = "expandtab",
  callback = check_expandtab
})

