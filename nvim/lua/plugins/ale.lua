-- ale
--

if vim.bo.filetype:match("lua") then
  local luacheckrc = vim.fn.expand("%:p:h") .. "/.luacheckrc"
  if vim.fn.filereadable(luacheckrc) then
    vim.g.ale_lua_luacheck_options = "--config " .. luacheckrc
  end
end

vim.g.ale_disable_lsp = 1
vim.g.ale_lint_on_text_changes = 0
vim.g.ale_lint_on_insert_leave = 0
vim.g.ale_lint_on_save = 1
vim.g.ale_lint_on_filetype_changed = 1
vim.g.ale_lint_on_enter = 1

