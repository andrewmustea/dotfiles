-- init.lua
--


-- nvim-web-devicons
--
require("nvim-web-devicons").get_icons()


-- filetype.nvim
--
require("filetype").setup({
  overrides = {
    literal = {
      ["env"] = "sh",
      ["gitconfig"] = "gitconfig",
      [".luacheckrc"] = "lua",
      ["profile"] = "sh",
      ["vimrc"] = "vim"
    }
  }
})

-- auto-session
--
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
require("auto-session").setup {
  log_level = "error",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = { "~/", "/"},
  auto_session_use_git_branch = nil,
  bypass_session_save_file_types = nil,
  cwd_change_handling = {
    restore_upcoming_session = true,
    pre_cwd_changed_hook = nil,
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}


-- Comment.nvim
--
require("Comment").setup()


-- leap.nvim
--
require("leap").set_default_keymaps()


-- hop.nvim
--
require("hop").setup()


-- skip to end if using vscode
--
if vim.g.vscode ~= nil then
  goto done
end

-- nvim-tree
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


-- indent-blankline.nvim
--
vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
    space_char_blankline = " ",
}


-- nvim-treesitter
--
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = { "bash", "c", "cpp", "cuda", "dot", "go", "haskell",
    "html", "java", "json", "lua", "make", "markdown", "python", "regex",
    "rust", "todotxt", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  endwise = {
    enable = true,
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}


-- bufferline.nvim
--
require("bufferline").setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers =
      function(opts)
        local winlist = vim.fn.win_findbuf(tonumber(opts.id))
        if next(winlist) then
          local tablist = vim.fn.win_id2tabwin(winlist[1])
          if next(tablist) then
            return ""
          end
        end
        return string.format("(%s)", opts.id)
      end,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    diagnostics_indicator =
      function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    offsets = {
      {
        filetype = "NvimTree",
        highlight = "Directory",
        text_align = "left"
      }
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    sort_by = "tabs",
  }
}


-- lualine.nvim
--
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "black_sun",
    component_separators = { left = "|", right = "|" },
    section_separators = "",
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {"filename"},
    lualine_d = {require('auto-session-library').current_session_name},
    lualine_x = {"filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { "nvim-tree" }
}


-- gitsigns.nvim
--
require("gitsigns").setup()


-- nvim-lspconfig
--
require("lspconfig").sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"},
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


-- ale
--
if vim.bo.filetype:match("lua") then
  local luacheckrc = vim.fn.expand("%:p:h") .. "/.luacheckrc"
  if vim.fn.filereadable(luacheckrc) then
    vim.g.ale_lua_luacheck_options = "--config " .. luacheckrc
  end
end

::done::

