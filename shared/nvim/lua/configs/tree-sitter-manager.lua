#!/usr/bin/env lua

--
-- nvim/lua/configs/tree-sitter-manager.lua
--

-- https://github.com/romus204/tree-sitter-manager.nvim

require("tree-sitter-manager").setup({
  ensure_installed = {
    "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css",
    "cuda", "devicetree", "diff", "fennel", "gitattributes", "gitcommit",
    "gitignore", "git_rebase", "go", "haskell", "html", "http", "java",
    "javascript", "json", "kotlin", "latex", "llvm", "lua", "make", "markdown",
    "markdown_inline", "meson", "ninja", "perl", "python", "regex", "rust",
    "todotxt", "toml", "typescript", "vala", "vim", "vue", "yaml", "zig"
  },
  notify = true
})
