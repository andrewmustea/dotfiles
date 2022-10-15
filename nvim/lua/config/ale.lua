-- ale
--
local g = vim.g

-- ale settings
g.ale_disable_lsp = 1
g.ale_lint_on_text_changes = 0
g.ale_lint_on_insert_leave = 0
g.ale_lint_on_save = 1
g.ale_lint_on_filetype_changed = 1
g.ale_lint_on_enter = 1

-- include luacheckrc if available
if vim.bo.filetype:match("lua") then
  local luacheckrc = vim.fn.expand("%:p:h") .. "/.luacheckrc"
  if vim.fn.filereadable(luacheckrc) then
    g.ale_lua_luacheck_options = "--config " .. luacheckrc
  end
end

-- disable certain ShellCheck rules
g.ale_sh_shellcheck_options = "-x"

