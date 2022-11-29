-- coc.nvim
--

local api = vim.api
local fn  = vim.fn

local function map(mode, keys, exec, opts)
  vim.keymap.set(mode, keys, exec, opts or { silent = true, noremap = true })
end

vim.g.coc_global_extensions = {
  "coc-clangd", "coc-clang-format-style-options", "coc-cmake", "coc-css",
  "coc-cssmodules", "coc-deno", "coc-diagnostic", "coc-docker", "coc-eslint",
  "coc-explorer", "coc-fzf-preview", "coc-git", "coc-go", "coc-golines",
  "coc-highlight", "coc-html", "coc-htmlhint", "coc-sumneko-lua",
  "coc-html-css-support", "coc-java", "coc-jedi", "coc-json", "coc-lists",
  "coc-markdownlint", "coc-markdown-preview-enhanced", "coc-markmap",
  "coc-perl", "coc-prettier", "coc-pydocstring", "coc-pyright", "coc-rome",
  "coc-rust-analyzer","coc-sh", "coc-stylelintplus", "coc-stylelint",
  "coc-snippets", "coc-sql", "coc-toml", "coc-tag", "coc-tsserver",
  "coc-vimlsp", "coc-xml", "coc-yaml", "coc-yank"
}

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : "<TAB>" ', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- <C-l> will trigger a snippet expansion.
map("i", "<C-l>", "<Plug>(coc-snippets-expand)", { })

-- <C-j> will place a visual placeholder of the snippet.
map("v", "<C-j>", "<Plug>(coc-snippets-select)", { })

-- <C-space> triggers completion
map("i", "<C-space>", "coc#refresh()", { silent = true, noremap = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- Use K to show documentation in preview window.
function _G.show_docs()
  local cw = fn.expand("<cword>")
  if fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
    api.nvim_command("h " .. cw)
  elseif api.nvim_eval("coc#rpc#ready()") then
    fn.CocActionAsync("doHover")
  else
    api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
  end
end

map("n", "K", "<CMD>lua _G.show_docs()<CR>", {silent = true})

