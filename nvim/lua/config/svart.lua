-- svart.nvim
--

local map = vim.keymap.set

require("svart").configure {
  key_cancel = "<Esc>",       -- cancel search
  key_delete_char = "<BS>",   -- delete query char
  key_delete_word = "<C-W>",  -- delete query word
  key_delete_query = "<C-U>", -- delete whole query
  key_best_match = "<CR>",    -- jump to the best match
  key_next_match = "<C-N>",   -- select next match
  key_prev_match = "<C-P>",   -- select prev match

  label_atoms = "jfkdlsahgnuvrbytmiceoxwpqz", -- allowed label chars
  label_location = "end",                     -- possible values: "start", "end"
  label_max_len = 2,                          -- max label length
  label_min_query_len = 1,                    -- min query length required to show labels
  label_hide_irrelevant = true,               -- hide irrelevant labels after start typing label to go to

  search_update_register = true, -- update search (/) register with last used query after accepting match
  search_wrap_around = true,     -- wrap around when navigating to next/prev match
  search_multi_window = true,    -- search in multiple windows

  ui_dim_content = true, -- dim buffer content during search
}

map({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")        -- begin exact search
-- map({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>")   -- begin regex search
map({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>") -- repeat with last searched query

-- SvartDimmedContent = { default = true, link = "Comment" }
-- SvartMatch = { default = true, link = "Search" }
-- SvartMatchCursor = { default = true, link = "Cursor" }
-- SvartDimmedCursor = { default = true, link = "TermCursorNC" }
-- SvartLabel = { default = true, link = "IncSearch" }
-- SvartPrompt = { default = true, link = "MoreMsg" }
-- SvartErrorPrompt = { default = true, link = "ErrorMsg" }

