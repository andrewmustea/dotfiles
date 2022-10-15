-- telescope.nvim
--

require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
  pickers = {
    find_files = {
      hidden = false,
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
      -- find_command = { "fd", "--hidden", "--type", "file", "--follow", "--strip-cwd-prefix" },
      -- find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
  },
  defaults = {
    file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png" },
  }
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "ff", builtin.find_files, { })
vim.keymap.set("n", "fg", builtin.live_grep, { })
vim.keymap.set("n", "fb", builtin.buffers, { })
vim.keymap.set("n", "fh", builtin.help_tags, { })

require("telescope").load_extension("fzf")

