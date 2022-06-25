-- init.lua
--


-- nvim tree
--
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})


-- nvim-lspconfig
--
require('lspconfig').sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


-- filetype
--
require("filetype").setup({
  overrides = {
    literal = {
      ["env"] = "sh",
      ["gitconfig"] = "gitconfig",
      [".luacheckrc"] = "lua",
      ["vimrc"] = "vim"
    },
    complex = {
      ["^.*bash((?!\\.).)*$"] = "sh"
    }
  }
})


-- syntastic
--
if vim.fn.expand('%'):match('^.*bash[^.]*$') then
  vim.g.syntastic_sh_shellcheck_args = '-s bash'
end

