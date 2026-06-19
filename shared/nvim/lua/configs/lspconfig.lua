#!/usr/bin/env lua

--
-- nvim/lua/configs/lspconfig.lua
--

-- https://github.com/neovim/nvim-lspconfig

local lspconfig = require("lspconfig")
local map = vim.keymap.set

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local on_attach = function(_, bufnr)
  local opts = { silent = true, buffer = bufnr }

  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gy", vim.lsp.buf.type_definition, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "[g", function()
    vim.diagnostic.jump({ count = -1 })
  end, opts)
  map("n", "]g", function()
    vim.diagnostic.jump({ count = 1 })
  end, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
  map("n", "<leader>cl", vim.lsp.codelens.run, opts)

  map({ "n", "x" }, "<leader>f", function()
    require("conform").format({ bufnr = bufnr, lsp_format = "fallback" })
  end, opts)
end

vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ lsp_format = "fallback" })
end, {})

vim.api.nvim_create_user_command("OR", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  })
end, {})

local capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason-lspconfig").setup({
  ensure_installed = {
    "basedpyright",
    "bashls",
    "biome",
    "clangd",
    "cssls",
    "cssmodules_ls",
    "denols",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "lemminx",
    "lua_ls",
    "neocmake",
    "perlnavigator",
    "ruff",
    "rust_analyzer",
    "sqlls",
    "taplo",
    "ts_ls",
    "vimls",
    "yamlls",
  },
  automatic_installation = true,
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
          },
        },
      })
    end,

    -- denols and ts_ls conflict; scope each to its own root
    ["denols"] = function()
      lspconfig.denols.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })
    end,

    ["ts_ls"] = function()
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
      })
    end,
  },
})
