-- plugins.lua
--

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

-- returns a config file as a function from the config/ directory using a given name
local function get_config(name)
  return string.format("require(\"config/%s\")", name)
end

-- vscode conditional disable
local function not_vscode()
  return vim.g.vscode == nil
end

require("packer").startup(function(use)
    -- packer
    use "wbthomason/packer.nvim"

    -- session info
    use { "dstein64/vim-startuptime",
      cmd = "StartupTime",
      cond = not_vscode
    }
    use { "rmagatti/auto-session",
      cond = not_vscode,
      config = get_config("auto-session")
    }
    use { "tversteeg/registers.nvim",
      cond = not_vscode,
      config = function()
        require("registers").setup()
      end
    }

    -- ui
    use { "kyazdani42/nvim-web-devicons",
      cond = not_vscode,
      config = function()
        require("nvim-web-devicons").get_icons()
      end
    }
    use { "petertriho/nvim-scrollbar",
      cond = not_vscode,
      config = get_config("nvim-scrollbar")
    }
    use { "kevinhwang91/nvim-hlslens",
      cond = not_vscode,
      config = get_config("nvim-hlslens")
    }
    use { "rcarriga/nvim-notify",
      branch = "master",
      cond = not_vscode,
      config = get_config("nvim-notify")
    }
    use { "stevearc/dressing.nvim",
      cond = not_vscode,
      config = get_config("dressing")
    }

    -- buffers/windows
    use { "matbme/JABS.nvim",
      cmd = "JABSOpen",
      requires = "kyazdani42/nvim-web-devicons",
      cond = not_vscode,
      config = function()
        require("jabs").setup()
      end
    }
    use { "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      cond = not_vscode,
      config = get_config("bufferline")
    }
    use { "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "rmagatti/auto-session"
      },
      cond = not_vscode,
      config = get_config("lualine")
    }
    use { "j-hui/fidget.nvim",
      requires = "nvim-lualine/lualine.nvim",
      cond = not_vscode,
      config = function()
        require("fidget").setup()
      end
    }

    -- movement and targets
    use "tpope/vim-repeat"
    use "wellle/targets.vim"
    use "editorconfig/editorconfig-vim"
    use { "Darazaki/indent-o-matic",
      requires = "editorconfig/editorconfig-vim",
      config = get_config("indent-o-matic")
    }
    use { "phaazon/hop.nvim",
      config = function()
        require("hop").setup()
      end
    }
    use { "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end
    }
    use { "mg979/vim-visual-multi",
      branch = "master",
      cond = not_vscode
    }
    use { "rmagatti/goto-preview",
      cond = not_vscode,
      config = function()
        require("goto-preview").setup()
      end
    }
    use { "chentoast/marks.nvim",
      cond = not_vscode,
      config = function()
        require("marks").setup()
      end
    }

    -- text manipulation
    use "matze/vim-move"
    use { "gbprod/cutlass.nvim",
      config = get_config("cutlass")
    }
    use { "junegunn/vim-easy-align",
      config = get_config("vim-easy-align")
    }
    use { "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }
    use { "gbprod/substitute.nvim",
      config = get_config("substitute")
    }
    use { "gbprod/yanky.nvim",
      requires = "gbprod/substitute.nvim",
      config = get_config("yanky")
    }
    use { "windwp/nvim-autopairs",
      cond = not_vscode,
      config = get_config("nvim-autopairs")
    }

    -- keybinds
    use { "Pocco81/AbbrevMan.nvim",
      config = function()
        require("abbrev-man").setup()
      end
    }
    use { "mrjones2014/legendary.nvim",
      requires = {
        "nvim-telescope/telescope.nvim",
        "stevearc/dressing.nvim"
      },
      cond = not_vscode,
      config = get_config("legendary")
    }
    use { "sudormrfbin/cheatsheet.nvim",
      requires = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
      },
      cmd = { "Cheatsheet", "CheatsheetEdit" },
      cond = not_vscode
    }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      cond = not_vscode,
      config = get_config("nvim-treesitter")
    }
    use { "RRethy/nvim-treesitter-endwise",
      requires = "nvim-treesitter/nvim-treesitter",
      cond = not_vscode
    }
    use { "nvim-treesitter/playground",
      requires = "nvim-treesitter/nvim-treesitter",
      cond = not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects",
      requires = "nvim-treesitter/nvim-treesitter",
      cond = not_vscode
    }
    use { "nvim-treesitter/nvim-treesitter-refactor",
      requires = "nvim-treesitter/nvim-treesitter",
      cond = not_vscode
    }
    use { "m-demare/hlargs.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      cond = not_vscode,
      config = get_config("hlargs")
    }

    -- git
    use { "lewis6991/gitsigns.nvim",
      cond = not_vscode,
      config = function()
        require("gitsigns").setup()
      end
    }
    use { "samoshkin/vim-mergetool",
      cond = not_vscode
    }
    use { "tpope/vim-fugitive",
      cond = not_vscode
    }
    use { "junegunn/gv.vim",
      requires = "tpope/vim-fugitive",
      cond = not_vscode
    }

    -- diff
    use { "AndrewRadev/linediff.vim",
      event = "DiffUpdated",
      cond = not_vscode
    }
    use { "rickhowe/spotdiff.vim",
      event = "DiffUpdated",
      cond = not_vscode
    }

    -- lsp
    -- use { "neovim/nvim-lspconfig",
    --   cond = not_vscode,
    --   config = get_config("nvim-lspconfig")
    -- },
    use { "neoclide/coc.nvim",
      branch = "release",
      cond = not_vscode,
      config = get_config("coc")
    }

    -- file explorer
    use { "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      cond = not_vscode,
      config = function()
        require("nvim-tree").setup()
      end
    }

    -- telescope
    use { "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cond = not_vscode,
    }
    use { "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = {
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-lua/plenary.nvim",
        "LinArcX/telescope-command-palette.nvim",
        "LinArcX/telescope-scriptnames.nvim",
        "LinArcX/telescope-changes.nvim",
        "smartpde/telescope-recent-files",
        "nvim-telescope/telescope-file-browser.nvim"
      },
      cond = not_vscode,
      config = get_config("telescope")
    }

    -- syntax
    use { "andrewmustea/black_sun",
      cond = not_vscode,
      config = function()
        vim.api.nvim_command("colorscheme black_sun")
      end
    }
    use { "lukas-reineke/indent-blankline.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      config = get_config("indent-blankline")
    }
    use { "pangloss/vim-javascript",
      ft = "javascript",
      cond = not_vscode
    }
    use { "rust-lang/rust.vim",
      ft = "rust",
      cond = not_vscode
    }
    use { "andrewmustea/vim-bitbake",
      branch = "remove_newbb_newbbappend_from_BufReadPost",
      ft = "bitbake",
      cond = not_vscode
    }
    use { "arrufat/vala.vim",
      ft = "vala",
      cond = not_vscode
    }
    use { "cuducos/yaml.nvim",
      ft = { "yaml" },
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim"
      },
      cond = not_vscode
    }

    -- markdown
    use { "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = { "markdown", "vimwiki" },
      cond = not_vscode,
      setup = function()
        vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
      end
    }
    use { "ellisonleao/glow.nvim",
      ft = { "markdown", "vimwiki" },
      cond = not_vscode
    }
    use { "jghauser/follow-md-links.nvim",
      ft = { "markdown", "vimwiki" },
      cond = not_vscode,
      config = function()
        vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
      end
    }

    -- vimwiki
    use { "vimwiki/vimwiki",
      cond = not_vscode
    }

    -- linting
    use { "dense-analysis/ale",
      cond = not_vscode,
      config = get_config("ale")
    }
end)

