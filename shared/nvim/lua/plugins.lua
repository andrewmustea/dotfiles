#!/usr/bin/env lua

--
-- nvim/lua/plugins.lua
--


-- functions

local function not_vscode()
  return vim.g.vscode == nil
end


-- plugins list

return {
  -- libraries
  { "nvim-lua/plenary.nvim",
    lazy = true,
    cond = not_vscode
  },
  { "kyazdani42/nvim-web-devicons",
    cond = not_vscode,
    config = function()
      require("nvim-web-devicons").get_icons()
    end
  },
  { "stevearc/dressing.nvim",
    cond = not_vscode,
    config = function()
      require("configs.dressing")
    end
  },
  { "ibhagwan/fzf-lua",
    lazy = true,
    cond = not_vscode
  },

  -- session info
  { "chentoast/marks.nvim",
    cond = not_vscode,
    config = function()
      require("configs.marks")
    end
  },
  { "dstein64/vim-startuptime",
    cmd = "StartupTime"
  },

  -- ui
  { "andrewmustea/black_sun",
    cond = not_vscode,
    config = function()
      require("black_sun.black_sun")
    end,
    priority = 1000
  },
  { "petertriho/nvim-scrollbar",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens"
    },
    cond = not_vscode,
    config = function()
      require("configs.nvim-scrollbar")
    end
  },
  { "kevinhwang91/nvim-hlslens",
    cond = not_vscode,
    config = function()
      require("configs.nvim-hlslens")
    end
  },
  { "rcarriga/nvim-notify",
    cond = not_vscode,
    config = function()
      require("configs.nvim-notify")
    end
  },
  { "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    cond = not_vscode,
    config = function()
      require("configs.bufferline")
    end
  },
  { "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    cond = not_vscode,
    config = function()
      require("configs.lualine")
    end
  },
  { "tzachar/highlight-undo.nvim",
    cond = not_vscode,
    config = true
  },
  { "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    cond = not_vscode,
    config = function()
      require("configs.nvim-colorizer")
    end
  },
  { "famiu/bufdelete.nvim",
    cond = not_vscode
  },
  { "rmagatti/goto-preview",
  event = "BufEnter",
  dependencies = "rmagatti/logger.nvim",
  cond = not_vscode,
  config = function()
    require("goto-preview").setup({
      default_mappings = true
    })
  end
  },
  { "nacro90/numb.nvim",
    cond = not_vscode,
    config = true
  },

  -- movement
  "tpope/vim-repeat",
  "wellle/targets.vim",
  { "smoka7/hop.nvim",
    config = true
  },

  -- text manipulation
  "matze/vim-move",
  { "gbprod/cutlass.nvim",
    config = function()
      require("configs.cutlass")
    end
  },
  { "numToStr/Comment.nvim",
    event = "CursorMoved",
    config = true
  },
  { "gbprod/substitute.nvim",
    config = function()
      require("configs.substitute")
    end
  },
  { "gbprod/yanky.nvim",
    dependencies = "gbprod/substitute.nvim",
    config = function()
      require("configs.yanky")
    end
  },
  { "windwp/nvim-autopairs",
    event = "InsertEnter",
    cond = not_vscode,
    config = true
  },
  { "kylechui/nvim-surround",
    event = "CursorMoved",
    config = true
  },
  { "smjonas/live-command.nvim",
    cond = not_vscode,
    config = function()
      require("live-command").setup()
    end,
  },

  -- file settings
  { "Darazaki/indent-o-matic",
    event = "BufReadPost",
    config = function()
      require("configs.indent-o-matic")
    end
  },
  { "rust-lang/rust.vim",
    ft = "rust",
    cond = not_vscode
  },
  { "arrufat/vala.vim",
    ft = "vala",
    cond = not_vscode
  },
  { "cuducos/yaml.nvim",
    ft = "yaml",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cond = not_vscode
  },

  -- diff
  { "AndrewRadev/linediff.vim",
    event = "DiffUpdated",
    cond = not_vscode
  },

  -- tools
  { url = "https://codeberg.org/fosk/registers.nvim.git",
    cmd = "Registers",
    keys = {
      { "\"", mode = { "n", "v" }, desc = "registers.nvim \"" },
      { "<C-r>", mode = "i", desc = "registers.nvim <C-r>" }
    },
    cond = not_vscode,
    config = true
  },
  { "akinsho/toggleterm.nvim",
    event = "CmdlineEnter",
    config = true
  },
  { "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "Tree" },
    cond = not_vscode,
    config = function()
      require("configs.nvim-tree")
    end
  },
  { "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cond = not_vscode,
    config = true
  },
  { "jghauser/mkdir.nvim",
    cond = not_vscode
  },

  -- git
  { "lewis6991/gitsigns.nvim",
    cond = not_vscode,
    config = true
  },
  { "samoshkin/vim-mergetool",
    cmd = "MergetoolStart",
    cond = not_vscode
  },
  { "sindrets/diffview.nvim",
    event = "CmdlineEnter",
    cond = not_vscode
  },
  { "NeogitOrg/neogit",
    event = "CmdlineEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua"
    },
    cond = not_vscode,
    config = true
  },

  -- lsp and linting
  { "neoclide/coc.nvim",
    event = { "CursorHold", "CursorMoved" },
    branch = "release",
    cond = not_vscode,
    config = function()
      require("configs.coc")
    end
  },

  -- treesitter
    {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    cond = not_vscode,
    config = function()
      require("configs.tree-sitter-manager")
    end
  },
  { "kiyoon/treesitter-indent-object.nvim",
    cond = not_vscode,
    keys = require("configs.treesitter-indent-object")
  },
  {
    "kiyoon/indent-blankline-v2.nvim",
    cond = not_vscode,
    event = "BufReadPost",
    config = function()
      require("configs.indent-blankline-v2")
    end,
  },

  -- telescope
  { "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
    cond = not_vscode
  },
  { "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "fb" },
      { "fc" },
      { "ff" },
      { "fg" },
      { "fh" },
      { "fm" },
      { "fn" },
      { "fr" },
      { "fs" },
      { "ft" },
      { "fy" }
    },
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "crispgm/telescope-heading.nvim",
      "fannheyward/telescope-coc.nvim",
      "fcying/telescope-ctags-outline.nvim",
      "FeiyouG/command_center.nvim",
      "LinArcX/telescope-changes.nvim",
      "LinArcX/telescope-command-palette.nvim",
      "LinArcX/telescope-env.nvim",
      "LinArcX/telescope-scriptnames.nvim",
      "LukasPietzschmann/telescope-tabs",
      "olacin/telescope-cc.nvim",
      "nat-418/telescope-color-names.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-hop.nvim",
      "smartpde/telescope-recent-files"
    },
    cond = not_vscode,
    config = function()
      require("configs.telescope")
    end
  },

  -- markdown and rst
  { "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git restore .",
    ft = "markdown",
    cond = not_vscode,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end
  },
  { "ellisonleao/glow.nvim",
    ft = "markdown",
    cond = not_vscode
  },
  { "jghauser/follow-md-links.nvim",
    ft = "markdown",
    cond = not_vscode,
    config = function()
      vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
    end
  }
}
