#!/usr/bin/env lua

--
-- nvim/lua/config/auto-session.lua
--

-- https://github.com/rmagatti/auto-session

vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

require("auto-session").setup({
  log_level = "error",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath("data").."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = { "~/", "/"},
  auto_session_use_git_branch = nil,
  bypass_session_save_file_types = nil,
  cwd_change_handling = {
    restore_upcoming_session = true,
    pre_cwd_changed_hook = nil,
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end
  }
})
