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

local function string_product(keys)
    if #keys == 1 then
        return keys[1]
    end
    local keys_copy = {}
    for _, key in ipairs(keys) do
        table.insert(keys_copy, key)
    end
    local product = {}
    local first = table.remove(keys_copy, 1)
    for _, a in ipairs(first) do
        if type(a) ~= 'string' then
            vim.cmd('echoerr "Not a valid keys table"')
        end
        for _, b in ipairs(string_product(keys_copy)) do
            table.insert(product, a .. b)
        end
    end
    return product
end

local function expand_keys(keys)
    if type(keys) == 'string' then
        return {keys}
    elseif type(keys[1]) == 'string' then
        return keys
    else
        return string_product(keys)
    end
end

local function get_keys(modes, keys)
    if type(modes) == 'string' then
        modes = {modes}
    end
    local combinations = {}
    for _, mode in ipairs(modes) do
        for _, v in ipairs(expand_keys(keys)) do
            table.insert(combinations, {mode, v})
        end
    end
    return combinations
end

-- vscode conditional disable
local function not_vscode()
  return vim.g.vscode == nil
end

require("packer").startup {
  function(use)
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
      cmd = "Registers",
      keys = { { "n", "\"" }, { "v", "\"" }, { "i", "<C-r>" } },
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
    use { "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      cond = not_vscode,
      config = function()
        require("colorizer").setup()
      end
    }
    use { "petertriho/nvim-scrollbar",
      cond = not_vscode,
      config = get_config("nvim-scrollbar")
    }
    use { "kevinhwang91/nvim-hlslens",
      event = "CmdlineEnter",
      keys = { "n", "N" },
      cond = not_vscode,
      config = get_config("nvim-hlslens")
    }
    use { "rcarriga/nvim-notify",
      cmd = "Notifications",
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
      requires = "kyazdani42/nvim-web-devicons",
      cond = not_vscode,
      config = get_config("lualine")
    }

    -- movement and targets
    use "tpope/vim-repeat"
    use "wellle/targets.vim"
    use "editorconfig/editorconfig-vim"
    use { "Darazaki/indent-o-matic",
      requires = "editorconfig/editorconfig-vim",
      config = get_config("indent-o-matic")
    }
    use { "https://gitlab.com/madyanov/svart.nvim",
      keys = get_keys({"n", "x", "o" }, { "s", "gs" }),
      config = get_config("svart")
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
    use { "numToStr/Comment.nvim",
      event = "CursorMoved",
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
      event = "InsertEnter",
      cond = not_vscode,
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
    use { "mrjones2014/legendary.nvim",
      cmd = "Legendary",
      requires = {
        { "nvim-telescope/telescope.nvim", opt = true },
        "stevearc/dressing.nvim"
      },
      wants = "telescope.nvim",
      cond = not_vscode,
      config = get_config("legendary")
    }
    use { "sudormrfbin/cheatsheet.nvim",
      cmd = { "Cheatsheet", "CheatsheetEdit" },
      requires = {
        { "nvim-telescope/telescope.nvim", opt = true },
        { "nvim-lua/plenary.nvim", opt = true },
        { "nvim-lua/popup.nvim", opt = true }
      },
      wants = {
        "telescope.nvim",
        "plenary.nvim",
        "popup.nvim"
      },
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
      cmd = "TSPlaygroundToggle",
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
    use { "tanvirtin/vgit.nvim",
      cmd = "VGit",
      cond = not_vscode,
      requires = { "nvim-lua/plenary.nvim", opt = true },
      wants = "plenary.nvim",
      config = get_config("vgit")
    }
    use { "samoshkin/vim-mergetool",
      cmd = "MergetoolStart",
      cond = not_vscode
    }
    use { "tpope/vim-fugitive",
      event = "CmdlineEnter",
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
      event = { "CursorHold", "CursorMoved" },
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
    use { "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      keys = get_keys({ "n" }, { { "f" }, { "b", "c", "f", "g", "h", "n", "p", "r", "y" } }),
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
      cond = not_vscode,
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
      ft = "yaml",
      requires = {
        "nvim-treesitter/nvim-treesitter",
        { "nvim-telescope/telescope.nvim", opt = true }
      },
      wants = "telescope.nvim",
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
      cmd = "Vimwiki",
      ft = "vimwiki",
      cond = not_vscode
    }

    -- linting
    use { "dense-analysis/ale",
      cond = not_vscode,
      config = get_config("ale")
    }
  end
}

