-- plugins.lua
--


-- automatically run :PackerCompile whenever plugins.lua is updated
--
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
})


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
    "glts/vim-magnum",
    "glts/vim-radical",
    { "kyazdani42/nvim-web-devicons",
      cond = { not_vscode },
      config = function()
        require("nvim-web-devicons").get_icons()
      end
    }
  }


  -- vim session info
  use {
    { "dstein64/vim-startuptime",
      cmd = "StartupTime",
      cond = { not_vscode }
    },
    { "nathom/filetype.nvim",
      config = function()
        require("plugins.filetype")
      end
    },
    { "rmagatti/auto-session",
      cond = { not_vscode },
      config = function()
        require("plugins.auto-session")
      end
    },
    { "tversteeg/registers.nvim",
      cond = { not_vscode }
    }
  }


  -- text manipulation
  use {
    "matze/vim-move",
    "rstacruz/vim-closer",
    "svermeulen/vim-subversive",
    "tpope/vim-unimpaired",
    { "gbprod/cutlass.nvim",
      config = function()
        require("plugins.cutlass")
      end
    },
    { "junegunn/vim-easy-align",
      config = function()
        require("plugins.vim-easy-align")
      end
    },
    { "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    },
    { "svermeulen/vim-yoink",
      config = function()
        require("plugins.vim-yoink")
      end
    }
  }


  -- movement and targets
  use {
    "AndrewRadev/switch.vim",
    "mg979/vim-visual-multi",
    "tpope/vim-repeat",
    "editorconfig/editorconfig-vim",
    { "tpope/vim-sleuth", after = "editorconfig-vim" },
    "tpope/vim-speeddating",
    "wellle/targets.vim",
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
    { "tpope/vim-surround",
      requires = "vim-repeat",
      after = "vim-repeat"
    }
  }


  -- file explorer
  use {
    "kyazdani42/nvim-tree.lua",
    cond = { not_vscode }
  }


  -- syntax higlighting
  use {
    { "andrewmustea/black_sun",
      after = { "bufferline.nvim", "lualine.nvim", "nvim-treesitter" },
      cond = { not_vscode },
      config = function()
        vim.api.nvim_command("colorscheme black_sun")
      end
    },
    { "lukas-reineke/indent-blankline.nvim",
      cond = { not_vscode },
      config = function()
        require("plugins.indent-blankline")
      end
    },
    { "pangloss/vim-javascript",
      ft = "javascript",
      cond = { not_vscode }
    },
    { "rust-lang/rust.vim",
      ft = "rust",
      cond = { not_vscode }
    },
    { "kergoth/vim-bitbake",
      ft = "bitbake",
      cond = { not_vscode }
    }
  }


  -- treesitter
  use {
    { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      cond = { not_vscode },
      config = function()
        require("plugins.nvim-treesitter")
      end
    },
    { "RRethy/nvim-treesitter-endwise",
      requries = "nvim-treesitter",
      after = "nvim-treesitter",
      cond = { not_vscode }
    },
    { "nvim-treesitter/playground",
      requries = "nvim-treesitter",
      after = "nvim-treesitter",
      cond = { not_vscode }
    },
    { "nvim-treesitter/nvim-treesitter-textobjects",
      requries = "nvim-treesitter",
      after = "nvim-treesitter",
      cond = { not_vscode }
    },
    { "nvim-treesitter/nvim-treesitter-refactor",
      requries = "nvim-treesitter",
      after = "nvim-treesitter",
      cond = { not_vscode }
    }
  }


  -- diff
  use {
    { "AndrewRadev/linediff.vim",
      event = "DiffUpdated",
      cond = { not_vscode }
    },
    { "rickhowe/spotdiff.vim",
      event = "DiffUpdated",
      cond = { not_vscode }
    }
  }


  -- buffer and tab line
  use {
    "akinsho/bufferline.nvim",
    requires = "nvim-web-devicons",
    after = "nvim-web-devicons",
    cond = { not_vscode },
    config = function()
      require("plugins.bufferline")
    end
  }


  -- lualine
  use {
    { "nvim-lualine/lualine.nvim",
      requires = { "nvim-web-devicons", "auto-session" },
      after = { "nvim-web-devicons", "auto-session" },
      cond = { not_vscode },
      config = function()
        require("plugins.lualine")
      end
    },
    { "j-hui/fidget.nvim",
      requires = "lualine.nvim",
      after = "lualine.nvim",
      cond = { not_vscode },
      config = function()
        require("fidget").setup()
      end
    }
  }


  -- scrollbar
  use {
    { "petertriho/nvim-scrollbar",
      after = "coc.nvim",
      cond = { not_vscode },
      config = function()
        require("plugins.nvim-scrollbar")
      end
    },
    { "kevinhwang91/nvim-hlslens",
      after = "nvim-scrollbar",
      cond = { not_vscode },
      config = function()
        require("plugins.nvim-hlslens")
      end
    }
  }


  -- git
  use {
    { "lewis6991/gitsigns.nvim",
      cond = { not_vscode },
      config = function()
        require("gitsigns").setup()
      end
    },
    { "samoshkin/vim-mergetool",
      cond = { not_vscode }
    },
    { "tpope/vim-fugitive",
      cond = { not_vscode }
    },
    { "junegunn/gv.vim",
      requires = "vim-fugitive",
      after = "vim-fugitive",
      cond = { not_vscode }
    }
  }


  -- lsp
  use {
    "neovim/nvim-lspconfig",
    cond = { not_vscode },
    config = function()
      require("plugins.lspconfig")
    end
  }


  -- code completion
  use {
    "neoclide/coc.nvim",
    branch = "release",
    cond = { not_vscode },
    config = function()
      require("plugins.coc")
    end
  }


  -- fuzzy find file history
  use {
    "ibhagwan/fzf-lua",
    branch = "main",
    requires = "nvim-web-devicons",
    after = "nvim-web-devicons",
    cond = { not_vscode },
    config = function()
      require("plugins.fzf-lua")
    end
  }


  -- linting
  use {
    "dense-analysis/ale",
    cond = { not_vscode },
    config = function()
      require("plugins.ale")
    end
  }


  -- markdown preview
  use {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "vimwiki" },
    cond = { not_vscode },
    run = function()
      vim.fn["mkdp#util#install"]()
    end
  }


  -- vimwiki
  use{
    "vimwiki/vimwiki",
    cond = { not_vscode },
    ft = { "markdown", "vimwiki" }
  }
end)

