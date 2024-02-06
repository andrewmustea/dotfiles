#!/usr/bin/env lua

--
-- nvim/lua/plugins.lua
--

local utils = require("utils")

require("packer").startup({
  function(use)
    -- packer
    use "wbthomason/packer.nvim"

    -- session info
    use { "chentoast/marks.nvim",
      cond = utils.not_vscode,
      config = function()
        require("marks").setup()
      end
    }
    use { "dstein64/vim-startuptime",
      cmd = "StartupTime",
      cond = utils.not_vscode
    }

    -- ui
    use { "andrewmustea/black_sun",
      cond = utils.not_vscode,
      config = function()
        vim.cmd.colorscheme("black_sun")
      end
    }
    use { "kyazdani42/nvim-web-devicons",
      cond = utils.not_vscode,
      config = function()
        require("nvim-web-devicons").get_icons()
      end
    }
    use { "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      cond = utils.not_vscode,
      config = function()
        require("colorizer").setup()
      end
    }
    use { "petertriho/nvim-scrollbar",
      requires = {
        { "lewis6991/gitsigns.nvim", opt = true },
        { "kevinhwang91/nvim-hlslens", opt = true }
      },
      wants = "gitsigns.nvim",
      cond = utils.not_vscode,
      config = utils.get_config("nvim-scrollbar")
    }
    use { "kevinhwang91/nvim-hlslens",
      event = "CmdlineEnter",
      keys = { "n", "N" },
      cond = utils.not_vscode,
      config = utils.get_config("nvim-hlslens")
    }
    use { "rcarriga/nvim-notify",
      cmd = "Notifications",
      branch = "master",
      cond = utils.not_vscode,
      config = utils.get_config("nvim-notify")
    }
    use { "stevearc/dressing.nvim",
      cond = utils.not_vscode,
      config = utils.get_config("dressing")
    }
    use { "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      wants = "nvim-web-devicons",
      cond = utils.not_vscode,
      config = utils.get_config("bufferline")
    }
    use { "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      wants = "nvim-web-devicons",
      cond = utils.not_vscode,
      config = utils.get_config("lualine")
    }

    -- movement
    use "tpope/vim-repeat"
    use "wellle/targets.vim"
    use { "phaazon/hop.nvim",
      config = function()
        require("hop").setup()
      end
    }

    -- text manipulation
    use "matze/vim-move"
    use { "gbprod/cutlass.nvim",
      config = utils.get_config("cutlass")
    }
    use { "numToStr/Comment.nvim",
      event = "CursorMoved",
      config = function()
        require("Comment").setup()
      end
    }
    use { "gbprod/substitute.nvim",
      config = utils.get_config("substitute")
    }
    use { "gbprod/yanky.nvim",
      requires = "gbprod/substitute.nvim",
      config = utils.get_config("yanky")
    }
    use { "windwp/nvim-autopairs",
      event = "InsertEnter",
      cond = utils.not_vscode,
      config = function()
        require("nvim-autopairs").setup()
      end
    }
    use { "kylechui/nvim-surround",
      event = "CursorMoved",
      config = function()
        require("nvim-surround").setup()
      end
    }

    -- file settings
    use { "editorconfig/editorconfig-vim",
      event = "BufReadPost"
    }
    use { "Darazaki/indent-o-matic",
      event = "BufReadPost",
      requires = "editorconfig/editorconfig-vim",
      wants = "editorconfig-vim",
      config = utils.get_config("indent-o-matic")
    }
    use { "pangloss/vim-javascript",
      ft = "javascript",
      cond = utils.not_vscode
    }
    use { "rust-lang/rust.vim",
      ft = "rust",
      cond = utils.not_vscode
    }
    use { "arrufat/vala.vim",
      ft = "vala",
      cond = utils.not_vscode
    }
    use { "cuducos/yaml.nvim",
      ft = "yaml",
      requires = {
        { "nvim-telescope/telescope.nvim", opt = true },
        { "nvim-treesitter/nvim-treesitter", opt = true },
      },
      wants = {
        "nvim-treesitter",
        "telescope.nvim",
      },
      cond = utils.not_vscode
    }

    -- diff
    use { "AndrewRadev/linediff.vim",
      event = "DiffUpdated",
      cond = utils.not_vscode
    }
    use { "rickhowe/spotdiff.vim",
      event = "DiffUpdated",
      cond = utils.not_vscode
    }

    -- tools
    use { "tversteeg/registers.nvim",
      cmd = "Registers",
      keys = { { "n", "\"" }, { "v", "\"" }, { "i", "<C-r>" } },
      cond = utils.not_vscode,
      config = function()
        require("registers").setup()
      end
    }
    use { "akinsho/toggleterm.nvim",
      event = "CmdlineEnter",
      tag = "*",
      config = function()
        require("toggleterm").setup()
      end
    }
    use { "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      cond = utils.not_vscode,
      config = function()
        require("nvim-tree").setup()
      end
    }

    -- git
    use { "lewis6991/gitsigns.nvim",
      cond = utils.not_vscode,
      config = function()
        require("gitsigns").setup()
      end
    }
    use { "tanvirtin/vgit.nvim",
      event = { "CursorHold", "CmdlineEnter" },
      requires = { "nvim-lua/plenary.nvim", opt = true },
      wants = "plenary.nvim",
      cond = utils.not_vscode,
      config = utils.get_config("vgit")
    }
    use { "samoshkin/vim-mergetool",
      cmd = "MergetoolStart",
      cond = utils.not_vscode
    }
    use { "tpope/vim-fugitive",
      event = "CmdlineEnter",
      cond = utils.not_vscode
    }
    use { "NeogitOrg/neogit",
      event = "CmdlineEnter",
      requires = { "nvim-lua/plenary.nvim", opt = true },
      wants = "plenary.nvim",
      cond = utils.not_vscode,
      config = function()
        require("neogit").setup()
      end
    }

    -- lsp and linting
    use { "neoclide/coc.nvim",
      event = { "CursorHold", "CursorMoved" },
      branch = "release",
      cond = utils.not_vscode,
      config = utils.get_config("coc")
    }
    use { "dense-analysis/ale",
      cond = utils.not_vscode,
      config = utils.get_config("ale")
    }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      cond = utils.not_vscode,
      config = utils.get_config("nvim-treesitter")
    }
    use { "RRethy/nvim-treesitter-endwise",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
    use { "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-refactor",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-context",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
    use { "theHamsta/nvim-treesitter-pairs",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
    use { "m-demare/hlargs.nvim",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode,
      config = utils.get_config("hlargs")
    }
    use { "lukas-reineke/indent-blankline.nvim",
      tag = "v2.20.8",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode,
      config = utils.get_config("indent-blankline")
    }

    -- telescope
    use { "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      keys = utils.get_key_combinations({ "n" }, {
        { "f" }, { "b", "c", "f", "g", "h", "m", "n", "p", "r", "s", "t", "y" }
      }),
      branch = "0.1.x",
      requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "crispgm/telescope-heading.nvim", opt = true },
        { "fannheyward/telescope-coc.nvim", opt = true },
        { "fcying/telescope-ctags-outline.nvim", opt = true },
        { "FeiyouG/command_center.nvim", opt = true },
        { "LinArcX/telescope-changes.nvim", opt = true },
        { "LinArcX/telescope-command-palette.nvim", opt = true },
        { "LinArcX/telescope-env.nvim", opt = true },
        { "LinArcX/telescope-scriptnames.nvim", opt = true },
        { "LukasPietzschmann/telescope-tabs", opt = true },
        { "olacin/telescope-cc.nvim", opt = true },
        { "nat-418/telescope-color-names.nvim", opt = true },
        { "nvim-telescope/telescope-file-browser.nvim", opt = true },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
        { "nvim-telescope/telescope-hop.nvim", opt = true },
        { "nvim-telescope/telescope-packer.nvim", opt = true },
        { "smartpde/telescope-recent-files", opt = true }
      },
      wants = {
        "nvim-notify",
        "plenary.nvim",
        "command_center.nvim",
        "telescope-cc.nvim",
        "telescope-changes.nvim",
        "telescope-coc.nvim",
        "telescope-color-names.nvim",
        "telescope-command-palette.nvim",
        "telescope-ctags-outline.nvim",
        "telescope-env.nvim",
        "telescope-file-browser.nvim",
        "telescope-fzf-native.nvim",
        "telescope-heading.nvim",
        "telescope-hop.nvim",
        "telescope-packer.nvim",
        "telescope-recent-files",
        "telescope-scriptnames.nvim",
        "telescope-tabs"
      },
      cond = utils.not_vscode,
      config = utils.get_config("telescope")
    }

    -- markdown and rst
    use { "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
      cond = utils.not_vscode,
      setup = function()
        vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
      end
    }
    use { "ellisonleao/glow.nvim",
      ft = "markdown",
      cond = utils.not_vscode
    }
    use { "jghauser/follow-md-links.nvim",
      ft = "markdown",
      cond = utils.not_vscode,
      config = function()
        vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
      end
    }
    use { "jghauser/auto-pandoc.nvim",
      ft = "markdown",
      requires = { "nvim-lua/plenary.nvim", opt = true },
      wants = "plenary.nvim",
      cond = utils.not_vscode,
      config = function()
        require("auto-pandoc")
      end
    }
    use { "stsewd/sphinx.nvim",
      run = ":UpdateRemotePlugins",
      ft = "rst",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = utils.not_vscode
    }
  end
})
