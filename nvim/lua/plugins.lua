-- plugins.lua
--

local util = require("util")

require("packer").startup({
  function(use)
    -- packer
    use "wbthomason/packer.nvim"

    -- session info
    use { "dstein64/vim-startuptime",
      cmd = "StartupTime",
      cond = util.not_vscode
    }
    use { "rmagatti/auto-session",
      cond = util.not_vscode,
      config = util.get_config("auto-session")
    }
    use { "tversteeg/registers.nvim",
      cmd = "Registers",
      keys = { { "n", "\"" }, { "v", "\"" }, { "i", "<C-r>" } },
      cond = util.not_vscode,
      config = function()
        require("registers").setup()
      end
    }

    -- ui
    use { "kyazdani42/nvim-web-devicons",
      cond = util.not_vscode,
      config = function()
        require("nvim-web-devicons").get_icons()
      end
    }
    use { "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      cond = util.not_vscode,
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
      cond = util.not_vscode,
      config = util.get_config("nvim-scrollbar")
    }
    use { "kevinhwang91/nvim-hlslens",
      event = "CmdlineEnter",
      keys = { "n", "N" },
      cond = util.not_vscode,
      config = util.get_config("nvim-hlslens")
    }
    use { "rcarriga/nvim-notify",
      cmd = "Notifications",
      branch = "master",
      cond = util.not_vscode,
      config = util.get_config("nvim-notify")
    }
    use { "stevearc/dressing.nvim",
      cond = util.not_vscode,
      config = util.get_config("dressing")
    }

    -- buffers/windows
    use { "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      wants = "nvim-web-devicons",
      cond = util.not_vscode,
      config = util.get_config("bufferline")
    }
    use { "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      wants = "nvim-web-devicons",
      cond = util.not_vscode,
      config = util.get_config("lualine")
    }
    use { "akinsho/toggleterm.nvim",
      event = "CmdlineEnter",
      tag = "*",
      config = function()
        require("toggleterm").setup()
      end
    }

    -- movement and targets
    use "tpope/vim-repeat"
    use "wellle/targets.vim"
    use "editorconfig/editorconfig-vim"
    use { "Darazaki/indent-o-matic",
      requires = "editorconfig/editorconfig-vim",
      wants = "editorconfig-vim",
      config = util.get_config("indent-o-matic")
    }
    use { "https://gitlab.com/madyanov/svart.nvim",
      keys = util.get_keys({"n", "x", "o" }, { "s", "gs" }),
      config = util.get_config("svart")
    }
    use { "phaazon/hop.nvim",
      config = function()
        require("hop").setup()
      end
    }
    use { "kylechui/nvim-surround",
      event = "CursorMoved",
      config = function()
        require("nvim-surround").setup()
      end
    }
    use { "chentoast/marks.nvim",
      cond = util.not_vscode,
      config = function()
        require("marks").setup()
      end
    }

    -- text manipulation
    use "matze/vim-move"
    use { "gbprod/cutlass.nvim",
      config = util.get_config("cutlass")
    }
    use { "numToStr/Comment.nvim",
      event = "CursorMoved",
      config = function()
        require("Comment").setup()
      end
    }
    use { "gbprod/substitute.nvim",
      config = util.get_config("substitute")
    }
    use { "gbprod/yanky.nvim",
      requires = "gbprod/substitute.nvim",
      config = util.get_config("yanky")
    }
    use { "windwp/nvim-autopairs",
      event = "InsertEnter",
      cond = util.not_vscode,
      config = function()
        require("nvim-autopairs").setup()
      end
    }

    -- keybinds
    use { "Pocco81/AbbrevMan.nvim",
      event = "InsertEnter",
      config = function()
        require("abbrev-man").setup()
      end
    }
    use { "sudormrfbin/cheatsheet.nvim",
      cmd = { "Cheatsheet", "CheatsheetEdit" },
      requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "nvim-lua/popup.nvim", opt = true },
        { "nvim-telescope/telescope.nvim", opt = true },
      },
      wants = {
        "telescope.nvim",
        "plenary.nvim",
        "popup.nvim"
      },
      cond = util.not_vscode
    }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      cond = util.not_vscode,
      config = util.get_config("nvim-treesitter")
    }
    use { "RRethy/nvim-treesitter-endwise",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = util.not_vscode
    }
    use { "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = util.not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = util.not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-refactor",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = util.not_vscode
    }
    use { "m-demare/hlargs.nvim",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = util.not_vscode,
      config = util.get_config("hlargs")
    }

    -- git
    use { "lewis6991/gitsigns.nvim",
      cond = util.not_vscode,
      config = function()
        require("gitsigns").setup()
      end
    }
    use { "tanvirtin/vgit.nvim",
      cmd = "VGit",
      cond = util.not_vscode,
      requires = { "nvim-lua/plenary.nvim", opt = true },
      wants = "plenary.nvim",
      config = util.get_config("vgit")
    }
    use { "samoshkin/vim-mergetool",
      cmd = "MergetoolStart",
      cond = util.not_vscode
    }
    use { "tpope/vim-fugitive",
      event = "CmdlineEnter",
      cond = util.not_vscode
    }

    -- diff
    use { "AndrewRadev/linediff.vim",
      event = "DiffUpdated",
      cond = util.not_vscode
    }
    use { "rickhowe/spotdiff.vim",
      event = "DiffUpdated",
      cond = util.not_vscode
    }

    -- lsp
    -- use { "neovim/nvim-lspconfig",
    --   cond = util.not_vscode,
    --   config = util.get_config("nvim-lspconfig")
    -- },
    use { "neoclide/coc.nvim",
      event = { "CursorHold", "CursorMoved" },
      branch = "release",
      cond = util.not_vscode,
      config = util.get_config("coc")
    }

    -- file explorer
    use { "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      cond = util.not_vscode,
      config = function()
        require("nvim-tree").setup()
      end
    }

    -- telescope
    use { "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      keys = util.get_keys({ "n" }, { { "f" }, { "b", "c", "f", "g", "h", "n", "p", "r", "y" } }),
      branch = "0.1.x",
      requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
        { "LinArcX/telescope-command-palette.nvim", opt = true },
        { "LinArcX/telescope-scriptnames.nvim", opt = true },
        { "LinArcX/telescope-changes.nvim", opt = true },
        { "smartpde/telescope-recent-files", opt = true },
        { "nvim-telescope/telescope-file-browser.nvim", opt = true },
        { "nvim-telescope/telescope-packer.nvim", opt = true },
        { "fannheyward/telescope-coc.nvim", opt = true }
      },
      wants = {
        "plenary.nvim",
        "nvim-notify",
        "telescope-fzf-native.nvim",
        "telescope-command-palette.nvim",
        "telescope-scriptnames.nvim",
        "telescope-changes.nvim",
        "telescope-recent-files",
        "telescope-file-browser.nvim",
        "telescope-packer.nvim",
        "telescope-coc.nvim"
      },
      cond = util.not_vscode,
      config = util.get_config("telescope")
    }

    -- syntax
    use { "andrewmustea/black_sun",
      cond = util.not_vscode,
      config = function()
        vim.cmd.colorscheme("black_sun")
      end
    }
    use { "lukas-reineke/indent-blankline.nvim",
      requires = { "nvim-treesitter/nvim-treesitter", opt = true },
      wants = "nvim-treesitter",
      cond = util.not_vscode,
      config = util.get_config("indent-blankline")
    }
    use { "pangloss/vim-javascript",
      ft = "javascript",
      cond = util.not_vscode
    }
    use { "rust-lang/rust.vim",
      ft = "rust",
      cond = util.not_vscode
    }
    use { "andrewmustea/vim-bitbake",
      branch = "remove_newbb_newbbappend_from_BufReadPost",
      ft = "bitbake",
      cond = util.not_vscode
    }
    use { "arrufat/vala.vim",
      ft = "vala",
      cond = util.not_vscode
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
      cond = util.not_vscode
    }

    -- markdown
    use { "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = { "markdown", "vimwiki" },
      cond = util.not_vscode,
      setup = function()
        vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
      end
    }
    use { "ellisonleao/glow.nvim",
      ft = { "markdown", "vimwiki" },
      cond = util.not_vscode
    }
    use { "jghauser/follow-md-links.nvim",
      ft = { "markdown", "vimwiki" },
      cond = util.not_vscode,
      config = function()
        vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
      end
    }

    -- vimwiki
    use { "vimwiki/vimwiki",
      event = "CmdlineEnter",
      ft = "vimwiki",
      cond = util.not_vscode
    }

    -- linting
    use { "dense-analysis/ale",
      cond = util.not_vscode,
      config = util.get_config("ale")
    }
  end
})

