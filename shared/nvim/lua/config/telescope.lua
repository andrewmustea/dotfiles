#!/usr/bin/env lua

--
-- nvim/lua/config/telescope.lua
--

-- https://github.com/nvim-telescope/telescope.nvim

local api = vim.api
local map = vim.keymap.set
local telescope = require("telescope")

-- load required plugins
api.nvim_command("packadd plenary.nvim")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png" }
  },
  extensions = {
    command_palette = {
      { "Telescope",
        { "buffers", ":lua require('telescope.builtin').buffers()" }
      },
      { "File",
        { "entire selection (C-a)", ":call feedkeys('GVgg')" },
        { "save current file (C-s)", ":w" },
        { "save all files (C-A-s)", ":wa" },
        { "quit (C-q)", ":qa" },
        { "file browser (C-i)", ":lua require('telescope').extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 }
      },
      { "Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 }
      },
      { "Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { "check health", ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorscheme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ":set paste!" },
        { "cursor line", ":set cursorline!" },
        { "cursor column", ":set cursorcolumn!" },
        { "spell checker", ":set spell!" },
        { "relative number", ":set relativenumber!" },
        { "search highlighting (F12)", ":set hlsearch!" }
      }
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case"         -- or "ignore_case" or "respect_case"
    },
    hop = {
      -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
      keys = {
        "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
        "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
        "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
        "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"
      },

      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { "WarningMsg", "Title" },
      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { "CursorLine", "Normal" },

      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true
    },
    recent_files = {
      stat_files = true,
      only_cwd = false
    },
    telescope_tabs = {
      close_tab_shortcut_i = '<C-d>', -- if you're in insert mode
      close_tab_shortcut_n = 'D',     -- if you're in normal mode
      show_preview = true
    }
  },
  pickers = {
    find_files = {
      hidden = false
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true
    }
      -- find_command = { "fd", "--hidden", "--type", "file", "--follow", "--strip-cwd-prefix" },
      -- find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
  }
})

-- load extensions
telescope.load_extension("changes")
telescope.load_extension("coc")
telescope.load_extension("color_names")
telescope.load_extension("command_center")
telescope.load_extension("command_palette")
telescope.load_extension("conventional_commits")
telescope.load_extension("ctags_outline")
telescope.load_extension("env")
telescope.load_extension("file_browser")
telescope.load_extension("fzf")
telescope.load_extension("heading")
telescope.load_extension("hop")
telescope.load_extension("packer")
telescope.load_extension("recent_files")
telescope.load_extension("scriptnames")
telescope.load_extension("telescope-tabs")
telescope.load_extension("yank_history")

-- keybinds

local opts = { silent = true, noremap = true }

-- builtin
map("n", "fb", function() return require("telescope.builtin").buffers() end, opts)
map("n", "ff", function() return require("telescope.builtin").find_files() end, opts)
map("n", "fg", function() return require("telescope.builtin").live_grep() end, opts)
map("n", "fh", function() return require("telescope.builtin").highlights() end, opts)
map("n", "fm", function() return require("telescope.builtin").marks() end, opts)
map("n", "fs", function() return require("telescope.builtin").search_history() end, opts)

-- extension keybinds
map("n", "fc", function() return require("telescope").extensions.coc.coc() end, opts)
map("n", "fn", function() return require("telescope").extensions.notify.notify() end, opts)
map("n", "fp", function() return require("telescope").extensions.packer.packer() end, opts)
map("n", "fr", function() return require("telescope").extensions.file_browser.file_browser() end, opts)
map("n", "ft", function() return require("telescope-tabs").list_tabs() end, opts)
map("n", "fy", function() return require("telescope").extensions.yank_history.yank_history() end, opts)
