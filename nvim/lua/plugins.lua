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
  use("wbthomason/packer.nvim")


  -- libraries
  use("glts/vim-magnum")
  use("glts/vim-radical")
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").get_icons()
    end
  })


  -- vim session info
  use("editorconfig/editorconfig-vim")
  use({
    "nathom/filetype.nvim",
    config = function()
      require("plugins.filetype")
    end
  })


  -- text manipulation
  use({
    "junegunn/vim-easy-align",
    config = function()
      require("plugins.vim-easy-align")
    end
  })
  use("matze/vim-move")
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  })
  use("rstacruz/vim-closer")
  use("svermeulen/vim-subversive")
  use({
    "svermeulen/vim-yoink",
    config = function()
      require("plugins.vim-yoink")
    end
  })
  use("tpope/vim-unimpaired")
  use({
    "gbprod/cutlass.nvim",
    config = function()
      require("plugins.cutlass")
    end
  })


  -- movement and targets
  use("AndrewRadev/switch.vim")
  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end
  })
  use("mg979/vim-visual-multi")
  use({
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()
    end
  })
  use("tpope/vim-repeat")
  use("tpope/vim-sleuth")
  use("tpope/vim-speeddating")
  use({
    "tpope/vim-surround",
    requires = "vim-repeat",
  })
  use("wellle/targets.vim")


  --
  -- non-vscode plugins
  --

  -- file explorer
  use({
    "kyazdani42/nvim-tree.lua",
    cond = { not_vscode }
  })


  -- syntax higlighting
  use({
    "andrewmustea/black_sun",
    after = { "bufferline.nvim", "lualine.nvim", "nvim-treesitter" },
    cond = { not_vscode },
    config = function()
      vim.api.nvim_command("colorscheme black_sun")
    end
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    cond = { not_vscode },
    config = function()
      require("plugins.indent-blankline")
    end
  })
  use({
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      cond = { not_vscode },
      config = function()
        require("plugins.nvim-treesitter")
      end
    },
    { "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter", cond = { not_vscode } },
    { "nvim-treesitter/playground", after = "nvim-treesitter", cond = { not_vscode } },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter", cond = { not_vscode } },
    { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter", cond = { not_vscode } }
  })
  use({
    "pangloss/vim-javascript",
    ft = "javascript",
    cond = { not_vscode }
  })
  use({
    "rust-lang/rust.vim",
    ft = "rust",
    cond = { not_vscode }
  })
  use({
    "kergoth/vim-bitbake",
    ft = "bb",
    cond = { not_vscode }
  })


  -- vim session info
  use({
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    cond = { not_vscode }
  })
  use({
    "rmagatti/auto-session",
    cond = { not_vscode },
    config = function()
      require("plugins.auto-session")
    end
  })
  use({
    "tversteeg/registers.nvim",
    cond = { not_vscode }
  })


  -- diff
  use({
    "AndrewRadev/linediff.vim",
    event = "DiffUpdated",
    cond = { not_vscode }
  })
  use({
    "rickhowe/spotdiff.vim",
    event = "DiffUpdated",
    cond = { not_vscode }
  })


  -- buffer and tab line
  use({
    "akinsho/bufferline.nvim",
    requires = "nvim-web-devicons",
    cond = { not_vscode },
    config = function()
      require("plugins.bufferline")
    end
  })


  -- lualine
  use({
    {
      "nvim-lualine/lualine.nvim",
      requires = "nvim-web-devicons",
      cond = { not_vscode },
      config = function()
        require("plugins.lualine")
      end
    },
    {
      "j-hui/fidget.nvim",
      requires = "lualine.nvim",
      cond = { not_vscode },
      config = function()
        require("fidget").setup()
      end
    }
  })


  -- git
  use({
    "lewis6991/gitsigns.nvim",
    cond = { not_vscode },
    config = function()
      require("gitsigns").setup()
    end
  })
  use({
    "samoshkin/vim-mergetool",
    cond = { not_vscode }
  })
  use({
    {
      "tpope/vim-fugitive",
      cond = { not_vscode }
    },
    {
      "junegunn/gv.vim",
      requires = "vim-fugitive",
      cond = { not_vscode }
    }
  })


  -- lsp
  use({
    "neovim/nvim-lspconfig",
    cond = { not_vscode },
    config = function()
      require("plugins.lspconfig")
    end
  })


  -- code completion
  use({
    "neoclide/coc.nvim",
    branch = "release",
    cond = { not_vscode },
    config = function()
      require("plugins.coc")
    end
  })


  -- fuzzy find file history
  use({
    "ibhagwan/fzf-lua",
    branch = "main",
    requires = "nvim-web-devicons",
    cond = { not_vscode },
    config = function()
      require("plugins.fzf-lua")
    end
  })


  -- linting
  use({
    "dense-analysis/ale",
    cond = { not_vscode },
    config = function()
      require("plugins.ale")
    end
  })


  -- markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "vimwiki" },
    cond = { not_vscode },
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })


  -- vimwiki
  use({
    "vimwiki/vimwiki",
    cond = { not_vscode },
    ft = { "markdown", "vimwiki" }
  })
end)

