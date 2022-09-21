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
  "coc-highlight", "coc-html", "coc-htmlhint", "coc-html-css-support",
  "coc-java", "coc-jedi", "coc-json", "coc-lists", "coc-markdownlint",
  "coc-markdown-preview-enhanced", "coc-markmap", "coc-perl", "coc-prettier",
  "coc-pydocstring", "coc-pyright", "coc-rome", "coc-rust-analyzer", "coc-sh",
  "coc-stylelintplus", "coc-stylelint", "coc-snippets", "coc-sql", "coc-toml",
  "coc-tsserver", "coc-vimlsp", "coc-xml", "coc-yaml", "coc-yank"
}

-- Use coc#pum#info() if you need to confirm completion, only when there's selected complete item:
-- inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
-- inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
--                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
-- inoremap <silent><expr> <TAB>
--       \ coc#pum#visible() ? coc#pum#next(1):
--       \ CheckBackspace() ? "\<Tab>" :
--       \ coc#refresh()
-- inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

-- map("i", "<TAB>",
--   "coc#pum#visible() ? coc#pum#next(1): CheckBackspace() ? \"\\<Tab>\" :coc#refresh()",
--   { silent = true, noremap = true, expr = true }
-- )

map("i", "<TAB>",
  function()
    local function check_backspace()
      local row, col = unpack(api.nvim_win_get_cursor(0))
      local linetext = api.nvim_get_current_line()
      return col == 0 or string.match(linetext:sub(col, col), '%s') ~= nil
    end
    if fn["coc#pum#visible"]() == 1 then
      fn["coc#pum#next"](1)
    elseif check_backspace() then
      return "<Tab>"
    else
      fn["coc#refresh"]()
    end
  end,
  { silent = true, noremap = true, expr = true }
)

map("i", "<S-TAB>",
  function()
    if fn["coc#pum#visible"]() == 1 then
      fn["coc#pum#prev"](1)
    else
      return "<C-h>"
    end
  end,
  { noremap = true, expr = true }
)

-- Use coc#pum#info() if you need to confirm completion, only when there's selected complete item:
-- inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"
-- map("i", "<CR>",
--   function()
--     if fn["coc#pum#visible"]() == 1 and fn["coc#pum#info"]()["index"] ~= -1 then
--       fn["coc#pum#confirm"]()
--     else
--       return "<CR>"
--     end
--   end,
--   { silent = true, noremap = true, expr = true }
-- )

-- Use <C-l> for trigger snippet expand.
-- imap <C-l> <Plug>(coc-snippets-expand)
map("i", "<C-l>", "<Plug>(coc-snippets-expand)", {})

-- Use <C-j> for select text for visual placeholder of snippet.
-- vmap <C-j> <Plug>(coc-snippets-select)
map("v", "<C-j>", "<Plug>(coc-snippets-select)", {})

-- <c-space> triggers completion
-- inoremap <silent><expr> <c-space> coc#refresh()
map("i", "<C-space>", "coc#refresh()", { silent = true, noremap = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
-- nmap <silent> [g <Plug>(coc-diagnostic-prev)
-- nmap <silent> ]g <Plug>(coc-diagnostic-next)
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- Use K to show documentation in preview window.
-- nnoremap <silent> K :call ShowDocumentation()<CR>
map("n", "K", ":lua ShowDocumentation()<CR>")

-- function! ShowDocumentation()
--   if CocAction('hasProvider', 'hover')
--     call CocActionAsync('doHover')
--   else
--     call feedkeys('K', 'in')
--   endif
-- endfunction

function ShowDocumentation()
  if fn.CocAction("hasProvider", "hover") then
    fn.CocActionAsync("doHover")
  else
    fn.feedkeys("K", "in")
  end
end

