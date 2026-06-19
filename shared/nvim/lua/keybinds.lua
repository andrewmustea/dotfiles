#!/usr/bin/env lua

--
-- nvim/lua/keybinds.lua
--

local function map(mode, keys, exec, opts)
  vim.keymap.set(mode, keys, exec, opts or { silent = true, noremap = true })
end

-- mimic shell movements
map("i", "<C-e>", "<End>")
map("i", "<C-a>", "<Home>")

map("c", "<C-a>", "<Home>", { noremap = true })
map("c", "<C-e>", "<End>", { noremap = true })

-- search for visual selection
map("v", "//", "y/\\V<C-R>=escape(@\",'/')<CR><CR>")

-- undo in insert mode
map("i", "<C-u>", "<ESC>ui", { noremap = true })

-- paste from + register while in insert mode
map("v", "<C-p>", '"+p')

-- vscode neovim plugin keybinds
if vim.g.vscode ~= nil then
  local function workbench_action(action)
    return "<Cmd>call VSCodeNotify('workbench.action." .. action .. "')<CR>"
  end

  map({ "n", "x" }, "<C-w><C-j>", workbench_action("focusBelowGroup"))
  map({ "n", "x" }, "<C-w><C-k>", workbench_action("focusAboveGroup"))
  map({ "n", "x" }, "<C-w><C-h>", workbench_action("focusLeftGroup"))
  map({ "n", "x" }, "<C-w><C-l>", workbench_action("focusRightGroup"))

  map({ "n", "x" }, "<C-w><S-j>", workbench_action("moveEditorToBelowGroup"))
  map({ "n", "x" }, "<C-w><S-k>", workbench_action("moveEditorToAboveGroup"))
  map({ "n", "x" }, "<C-w><S-h>", workbench_action("moveEditorToLeftGroup"))
  map({ "n", "x" }, "<C-w><S-l>", workbench_action("moveEditorToRightGroup"))

  map({ "n", "x" }, "<C-w><M-j>", workbench_action("moveActiveEditorGroupDown"))
  map({ "n", "x" }, "<C-w><M-k>", workbench_action("moveActiveEditorGroupUp"))
  map({ "n", "x" }, "<C-w><M-h>", workbench_action("moveActiveEditorGroupLeft"))
  map({ "n", "x" }, "<C-w><M-l>", workbench_action("moveActiveEditorGroupRight"))

-- fix the kitty keyboard protocol in vscode terminal
elseif vim.env.TERM_PROGRAM == "vscode" then
  for key, char in pairs({
    ["<S-1>"] = "!",
    ["<S-2>"] = "@",
    ["<S-3>"] = "#",
    ["<S-4>"] = "$",
    ["<S-5>"] = "%",
    ["<S-6>"] = "^",
    ["<S-7>"] = "&",
    ["<S-8>"] = "*",
    ["<S-9>"] = "(",
    ["<S-0>"] = ")",
  }) do
    map({ "n", "v", "o", "i", "c" }, key, char, { noremap = true })
  end
end
