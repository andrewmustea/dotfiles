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
--
local function not_vscode()
  return vim.g.vscode == nil
end


-- packer
--
require("packer").startup(function(use)


  -- packer can manage itself
  use "wbthomason/packer.nvim"


  -- libraries
  use {
    "kyazdani42/nvim-web-devicons",
      cond = not_vscode,
      config = function()
        require("nvim-web-devicons").get_icons()
      end
  }


  -- neovim session
  use {
    { "Pocco81/AbbrevMan.nvim",
      config = function()
        require("abbrev-man").setup()
      end
    },
    { "dstein64/vim-startuptime",
      cmd = "StartupTime",
      cond = not_vscode
    },
    { "rmagatti/auto-session",
      cond = not_vscode,
      config = get_config("auto-session")
    },
    { "tversteeg/registers.nvim",
      cond = not_vscode,
      config = function()
        require("registers").setup()
      end
    },
    { "mrjones2014/legendary.nvim",
      cond = not_vscode,
      config = get_config("legendary")
    }
  }

  -- windows and buffers
  use {
    { "famiu/bufdelete.nvim",
      cond = not_vscode
    },
    { "matbme/JABS.nvim",
      cmd = "JABSOpen",
      requires = "kyazdani42/nvim-web-devicons",
      cond = not_vscode,
      config = function()
        require("jabs").setup()
      end
    }
  }


  -- text manipulation
  use {
    "matze/vim-move",
    { "gbprod/cutlass.nvim",
      config = get_config("cutlass")
    },
    { "junegunn/vim-easy-align",
      config = get_config("vim-easy-align")
    },
    { "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    },
    { "gbprod/yanky.nvim",
      config = get_config("yanky")
    }
  }


  -- movement and targets
  use {
    "tpope/vim-repeat",
    "wellle/targets.vim",
    "editorconfig/editorconfig-vim",
    { "tpope/vim-sleuth",
      after = "editorconfig-vim"
    },
    { "ggandor/leap.nvim",
      config = function()
        require("leap").set_default_keymaps()
      end
    },
    { "phaazon/hop.nvim",
      config = function()
        require("hop").setup()
      end
    },
    { "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end
    },
    { "mg979/vim-visual-multi",
      branch = "master",
      cond = not_vscode
    },
    { "rmagatti/goto-preview",
      cond = not_vscode,
      config = function()
        require("goto-preview").setup()
      end
    },
    { "chentoast/marks.nvim",
      cond = not_vscode,
      config = function()
        require("marks").setup()
      end
    },
  }


  -- file explorer
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    cond = not_vscode,
    config = function()
      require("nvim-tree").setup()
    end
  }


  -- syntax higlighting
  use {
    { "andrewmustea/black_sun",
      cond = not_vscode,
      config = function()
        vim.api.nvim_command("colorscheme black_sun")
      end
    },
    { "lukas-reineke/indent-blankline.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      after = "nvim-treesitter",
      cond = not_vscode,
      config = get_config("indent-blankline")
    },
    { "pangloss/vim-javascript",
      ft = "javascript",
      cond = not_vscode
    },
    { "rust-lang/rust.vim",
      ft = "rust",
      cond = not_vscode
    },
    { "andrewmustea/vim-bitbake",
      branch = "remove_newbb_newbbappend_from_BufReadPost",
      ft = "bitbake",
      cond = not_vscode
    },
    { "arrufat/vala.vim",
      ft = "vala",
      cond = not_vscode
    }
  }


  -- treesitter
  use {
    { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      cond = not_vscode,
      config = get_config("nvim-treesitter")
    },
    { "RRethy/nvim-treesitter-endwise",
      requires = "nvim-treesitter/nvim-treesitter",
      after = {
        "nvim-treesitter",
        "telescope.nvim"
      },
      cond = not_vscode
    },
    { "nvim-treesitter/playground",
      requires = "nvim-treesitter/nvim-treesitter",
      after = {
        "nvim-treesitter",
        "telescope.nvim"
      },
      cond = not_vscode
    },
    { "nvim-treesitter/nvim-treesitter-textobjects",
      requires = "nvim-treesitter/nvim-treesitter",
      after = {
        "nvim-treesitter",
        "telescope.nvim"
      },
      cond = not_vscode
    },
    { "nvim-treesitter/nvim-treesitter-refactor",
      requires = "nvim-treesitter/nvim-treesitter",
      after = {
        "nvim-treesitter",
        "telescope.nvim"
      },
      cond = not_vscode
    },
    { "m-demare/hlargs.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      after = {
        "nvim-treesitter",
        "telescope.nvim"
      },
      cond = not_vscode,
      config = get_config("hlargs")
    }
  }


  -- diff
  use {
    { "AndrewRadev/linediff.vim",
      event = "DiffUpdated",
      cond = not_vscode
    },
    { "rickhowe/spotdiff.vim",
      event = "DiffUpdated",
      cond = not_vscode
    }
  }


  -- buffer and tab line
  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    after = "nvim-web-devicons",
    cond = not_vscode,
    config = get_config("bufferline")
  }


  -- lualine
  use {
    { "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "rmagatti/auto-session"
      },
      cond = not_vscode,
      config = get_config("lualine")
    },
    { "j-hui/fidget.nvim",
      requires = "nvim-lualine/lualine.nvim",
      cond = not_vscode,
      config = function()
        require("fidget").setup()
      end
    }
  }


  -- scrollbar
  use {
    { "petertriho/nvim-scrollbar",
      after = "coc.nvim",
      cond = not_vscode,
      config = get_config("nvim-scrollbar")
    },
    { "kevinhwang91/nvim-hlslens",
      after = "nvim-scrollbar",
      cond = not_vscode,
      config = get_config("nvim-hlslens")
    }
  }


  -- git
  use {
    { "lewis6991/gitsigns.nvim",
      cond = not_vscode,
      config = function()
        require("gitsigns").setup()
      end
    },
    { "samoshkin/vim-mergetool",
      cond = not_vscode
    },
    { "tpope/vim-fugitive",
      cond = not_vscode
    },
    { "junegunn/gv.vim",
      requires = "tpope/vim-fugitive",
      cond = not_vscode
    }
  }


  -- lsp
  -- use {
  --   "neovim/nvim-lspconfig",
  --   cond = not_vscode,
  --   config = get_config("nvim-lspconfig")
  -- }
  use {
    "neoclide/coc.nvim",
    branch = "release",
    cond = not_vscode,
    config = get_config("coc")
  }


  -- fuzzy find
  use {
    "ibhagwan/fzf-lua",
    branch = "main",
    requires = "kyazdani42/nvim-web-devicons",
    cond = not_vscode,
    config = get_config("fzf-lua")
  }


  -- telescope
  use {
    { "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "LinArcX/telescope-command-palette.nvim",
        "LinArcX/telescope-scriptnames.nvim",
        "LinArcX/telescope-changes.nvim",
        "smartpde/telescope-recent-files"
      },
      after = "telescope-fzf-native.nvim",
      cond = not_vscode,
      config = get_config("telescope")
    },
    { "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cond = not_vscode,
    },
  }


  -- linting
  use {
    "dense-analysis/ale",
    cond = not_vscode,
    config = get_config("ale")
  }


  -- markdown
  use {
    { "iamcco/markdown-preview.nvim",
      ft = { "markdown", "vimwiki" },
      cond = not_vscode,
      run = function()
        vim.fn["mkdp#util#install"]()
      end
    },
    { "ellisonleao/glow.nvim",
      ft = { "markdown", "vimwiki" },
      cond = not_vscode
    },
    { "jghauser/follow-md-links.nvim",
      ft = { "markdown", "vimwiki" },
      cond = not_vscode,
      config = function()
        vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
      end
    }
  }


  -- vimwiki
  use {
    "vimwiki/vimwiki",
    ft = { "markdown", "vimwiki" },
    cond = not_vscode
  }


  -- filetypes
  use {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim"
    },
  }


  -- help
  use {
    "sudormrfbin/cheatsheet.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    cond = not_vscode
  }
end)

