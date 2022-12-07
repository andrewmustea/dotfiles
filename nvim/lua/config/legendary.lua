-- legendary.nvim
--

require("legendary").setup {
  -- Initial keymaps to bind
  keymaps = { },
  -- Initial commands to bind
  commands = { },
  -- Initial augroups/autocmds to bind
  autocmds = { },
  -- Initial functions to bind
  funcs = { },
  -- Initial item groups to bind,
  -- note that item groups can also
  -- be under keymaps, commands, autocmds, or funcs
  itemgroups = { },
  -- default opts to merge with the `opts` table
  -- of each individual item
  default_opts = {
    keymaps = { },
    commands = { },
    autocmds = { },
  },
  -- Customize the prompt that appears on your vim.ui.select() handler
  -- Can be a string or a function that returns a string.
  select_prompt = " legendary.nvim ",
  -- Character to use to separate columns in the UI
  col_separator_char = "│",
  -- Optionally pass a custom formatter function. This function
  -- receives the item as a parameter and the mode that legendary
  -- was triggered from (e.g. `function(item, mode): string[]`)
  -- and must return a table of non-nil string values for display.
  -- It must return the same number of values for each item to work correctly.
  -- The values will be used as column values when formatted.
  -- See function `default_format(item)` in
  -- `lua/legendary/ui/format.lua` to see default implementation.
  default_item_formatter = nil,
  -- Include builtins by default, set to false to disable
  include_builtin = true,
  -- Include the commands that legendary.nvim creates itself
  -- in the legend by default, set to false to disable
  include_legendary_cmds = true,
  -- Options for list sorting. Note that fuzzy-finders will still
  -- do their own sorting. For telescope.nvim, you can set it to use
  -- `require("telescope.sorters").fuzzy_with_index_bias({ })` when
  -- triggered via `legendary.nvim`. Example config for `dressing.nvim`:
  --
  -- require("dressing").setup({
  --  select = {
  --    get_config = function(opts)
  --      if opts.kind == "legendary.nvim" then
  --        return {
  --          telescope = {
  --            sorter = require("telescope.sorters").fuzzy_with_index_bias({ })
  --          }
  --        }
  --      else
  --        return { }
  --      end
  --    end
  --  }
  -- })
  sort = {
    -- sort most recently used item to the top
    most_recent_first = true,
    -- sort user-defined items before built-in items
    user_items_first = true,
    -- sort the specified item type before other item types,
    -- value must be one of: "keymap", "command", "autocmd", nil
    item_type_bias = nil,
  },
  which_key = {
    -- Automatically add which-key tables to legendary
    -- see ./doc/WHICH_KEY.md for more details
    auto_register = false,
    -- you can put which-key.nvim tables here,
    -- or alternatively have them auto-register,
    -- see ./doc/WHICH_KEY.md
    mappings = { },
    opts = { },
    -- controls whether legendary.nvim actually binds they keymaps,
    -- or if you want to let which-key.nvim handle the bindings.
    -- if not passed, true by default
    do_binding = true,
  },
  scratchpad = {
    -- How to open the scratchpad buffer,
    -- "current" for current window, "float"
    -- for floating window
    view = "float",
    -- How to show the results of evaluated Lua code.
    -- "print" for `print(result)`, "float" for a floating window.
    results_view = "float",
    -- Border style for floating windows related to the scratchpad
    float_border = "rounded",
    -- Whether to restore scratchpad contents from a cache file
    keep_contents = true,
  },
  -- Directory used for caches
  cache_path = string.format("%s/legendary/", vim.fn.stdpath("cache")),
  -- Log level, one of "trace", "debug", "info", "warn", "error", "fatal"
  log_level = "info",
}
