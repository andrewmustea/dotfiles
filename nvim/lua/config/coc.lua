-- coc.nvim
--

local api = vim.api
local fn  = vim.fn
local map = vim.keymap.set

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

----------------
-- Completion --
----------------

local completion_opts = { silent = true, noremap = true, expr = true }

-- <Tab> will select the next completion selection
map("i", "<Tab>",
  function()
    if api.nvim_eval("coc#pum#visible()") == 1 then
      return api.nvim_call_function("coc#pum#next", { 1 })
    else
      return "<Tab>"
    end
  end,
  completion_opts
)

-- <S-Tab> will select the previous completion selection
map("i", "<S-Tab>",
  function()
    if api.nvim_eval("coc#pum#visible()") == 1 then
      return api.nvim_call_function("coc#pum#prev", { 1 })
    else
      return "<S-Tab>"
    end
  end,
  completion_opts
)

-- <C-space> triggers completion or removes the completion popup
map("i", "<C-space>",
  function()
    if api.nvim_eval("coc#pum#visible()") == 1 then
      return api.nvim_call_function("coc#pum#stop", { })
    else
      return api.nvim_call_function("coc#refresh", { })
    end
  end,
  completion_opts
)

-- <C-l> will trigger a snippet expansion
map("i", "<C-l>", "<Plug>(coc-snippets-expand-jump)", { silent = true, noremap = true })

-- <C-j> will place a visual placeholder of the snippet
map("v", "<C-j>", "<Plug>(coc-snippets-select)", { silent = true, noremap = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- Code navigation
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Rename symbol
map("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

--------------
-- Autocmds --
--------------

api.nvim_create_augroup("CocGroup", { })

-- Setup formatexpr specified filetypess
api.nvim_create_autocmd("FileType", {
  group = "CocGroup",
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = "Setup formatexpr specified filetypes"
})

-- Update signature help on jump placeholder
api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
  desc = "Update signature help on jump placeholder"
})

----------------
-- CodeAction --
----------------

-- Example: `<leader>aap` for current paragraph

local code_action_opts = { silent = true, nowait = true }

map({ "x", "n" }, "<leader>a", "<Plug>(coc-codeaction-selected)", code_action_opts)

-- Remap keys for applying codeAction to the current buffer
map("n", "<leader>ac", "<Plug>(coc-codeaction)", code_action_opts)

-- Apply AutoFix to problem on the current line
map("n", "<leader>qf", "<Plug>(coc-fix-current)", code_action_opts)

-- Run the Code Lens action on the current line
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", code_action_opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)", code_action_opts)
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)", code_action_opts)
map({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)", code_action_opts)
map({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)", code_action_opts)

------------------------
-- Windows and Popups --
------------------------

local float_opts = { silent = true, nowait = true, expr = true }

-- Use K to show documentation in preview window
map("n", "K", function() _G.show_docs() end, { silent = true })

function _G.show_docs()
  if api.nvim_eval("coc#float#has_float()") == 1 then
    api.nvim_call_function("coc#float#close_all", { })
  else
    local cw = fn.expand("<cword>")
    if api.nvim_eval("coc#rpc#ready()") then
      fn.CocActionAsync("doHover")
    else
      api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
  end
end

-- Remap <C-f> to scroll up floating windows
map({ "n", "v", "i" }, "<C-f>",
  function()
    if api.nvim_eval("coc#float#has_scroll()") == 1 then
      api.nvim_call_function("coc#float#scroll", { 1 } )
    else
      return "<C-f>"
    end
  end,
  float_opts
)

-- Remap <C-b> to scroll down floating windows
map({ "n", "v", "i" }, "<C-b>",
  function()
    if api.nvim_eval("coc#float#has_scroll()") == 1 then
      api.nvim_call_function("coc#float#scroll", { 0 } )
    else
      return "<C-b>"
    end
  end,
  float_opts
)


----------------
-- Selections --
----------------

-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
-- map("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
-- map("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

----------------
-- Formatting --
----------------

-- Format selected code
map({ "x", "n" }, "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

-- Format current buffer
api.nvim_create_user_command("Format", "call CocAction('format')", { })

-- Fold current buffer
api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

-- Organize imports of the current buffer
api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", { })

-------------
-- CocList --
-------------

-- Mappings for CoCList
-- code actions and coc stuff

-- local list_opts = { silent = true, nowait = true }

-- Show all diagnostics
-- map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", list_opts)

-- Manage extensions
-- map("n", "<space>e", ":<C-u>CocList extensions<cr>", list_opts)

-- Show commands
-- map("n", "<space>c", ":<C-u>CocList commands<cr>", list_opts)

-- Find symbol of current document
-- map("n", "<space>o", ":<C-u>CocList outline<cr>", list_opts)

-- Search workspace symbols
-- map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", list_opts)

-- Do default action for next item
-- map("n", "<space>j", ":<C-u>CocNext<cr>", list_opts)

-- Do default action for previous item
-- map("n", "<space>k", ":<C-u>CocPrev<cr>", list_opts)

-- Resume latest coc list
-- map("n", "<space>p", ":<C-u>CocListResume<cr>", list_opts)

