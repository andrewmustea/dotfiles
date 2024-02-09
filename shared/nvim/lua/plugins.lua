#!/usr/bin/env lua

--
-- nvim/lua/plugins.lua
--

-- functions

local function not_vscode()
  return vim.g.vscode == nil
end

-- plugins list

local plugins = {
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
      require("config.dressing")
    end
  },

  -- session info
  { "chentoast/marks.nvim",
    cond = not_vscode,
    config = true
  },
  { "dstein64/vim-startuptime",
    cmd = "StartupTime"
  },

  -- ui
  { "andrewmustea/black_sun",
    cond = not_vscode,
    config = function()
      vim.cmd.colorscheme("black_sun")
    end
  },
  { "petertriho/nvim-scrollbar",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens"
    },
    cond = not_vscode,
    config = function()
      require("config.nvim-scrollbar")
    end
  },
  { "kevinhwang91/nvim-hlslens",
    cond = not_vscode,
    config = function()
      require("config.nvim-hlslens")
    end
  },
  { "rcarriga/nvim-notify",
    cond = not_vscode,
    config = function()
      require("config.nvim-notify")
    end
  },
  { "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    cond = not_vscode,
    config = function()
      require("config.bufferline")
    end
  },
  { "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    cond = not_vscode,
    config = function()
      require("config.lualine")
    end
  },

  -- movement
  "tpope/vim-repeat",
  "wellle/targets.vim",
  { "phaazon/hop.nvim",
    config = true
  },

  -- text manipulation
  "matze/vim-move",
  { "gbprod/cutlass.nvim",
    config = function()
      require("config.cutlass")
    end
  },
  { "numToStr/Comment.nvim",
    event = "CursorMoved",
    config = true
  },
  { "gbprod/substitute.nvim",
    config = function()
      require("config.substitute")
    end
  },
  { "gbprod/yanky.nvim",
    dependencies = "gbprod/substitute.nvim",
    config = function()
      require("config.yanky")
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

  -- file settings
  { "editorconfig/editorconfig-vim",
    event = "BufReadPost"
  },
  { "Darazaki/indent-o-matic",
    event = "BufReadPost",
    dependencies = "editorconfig/editorconfig-vim",
    config = function()
      require("config.indent-o-matic")
    end
  },
  { "pangloss/vim-javascript",
    ft = "javascript",
    cond = not_vscode
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
      "nvim-treesitter/nvim-treesitter",
    },
    cond = not_vscode
  },

  -- diff
  { "AndrewRadev/linediff.vim",
    event = "DiffUpdated",
    cond = not_vscode
  },
  { "rickhowe/spotdiff.vim",
    event = "DiffUpdated",
    cond = not_vscode
  },

  -- tools
  { "tversteeg/registers.nvim",
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
    config = true
  },
  { "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = not_vscode,
    config = true
  },

  -- git
  { "lewis6991/gitsigns.nvim",
    cond = not_vscode,
    config = true
  },
  { "tanvirtin/vgit.nvim",
    event = { "CursorHold", "CmdlineEnter" },
    dependencies = "nvim-lua/plenary.nvim",
    cond = not_vscode,
    config = function()
      require("config.vgit")
    end
  },
  { "samoshkin/vim-mergetool",
    cmd = "MergetoolStart",
    cond = not_vscode
  },
  { "tpope/vim-fugitive",
    event = "CmdlineEnter",
    cond = not_vscode
  },
  { "NeogitOrg/neogit",
    event = "CmdlineEnter",
    dependencies = "nvim-lua/plenary.nvim",
    cond = not_vscode,
    config = true
  },

  -- lsp and linting
  { "neoclide/coc.nvim",
    event = { "CursorHold", "CursorMoved" },
    branch = "release",
    cond = not_vscode,
    config = function()
      require("config.coc")
    end
  },
  { "dense-analysis/ale",
    cond = not_vscode,
    config = function()
      require("config.ale")
    end
  },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cond = not_vscode,
    config = function()
      require("config.nvim-treesitter")
    end
  },
  { "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  },
  { "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  },
  { "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  },
  { "nvim-treesitter/nvim-treesitter-refactor",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  },
  { "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  },
  { "theHamsta/nvim-treesitter-pairs",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  },
  { "m-demare/hlargs.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode,
    config = function()
      require("config.hlargs")
    end
  },
  { "lukas-reineke/indent-blankline.nvim",
    tag = "v2.20.8",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode,
    config = function()
      require("config.indent-blankline")
    end
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
      require("config.telescope")
    end
  },

  -- markdown and rst
  { "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git restore .",
    ft = "markdown",
    cond = not_vscode,
    setup = function()
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
  },
  { "jghauser/auto-pandoc.nvim",
    ft = "markdown",
    dependencies = "nvim-lua/plenary.nvim",
    cond = not_vscode,
    config = function()
      require("auto-pandoc")
    end
  },
  { "stsewd/sphinx.nvim",
    build = ":UpdateRemotePlugins",
    ft = "rst",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = not_vscode
  }
}

return plugins
