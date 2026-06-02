#!/usr/bin/env lua

--
-- nvim/lua/configs/treesitter-indent-object.lua
--

-- https://github.com/kiyoon/treesitter-indent-object.nvim

return {
  { "ai",
    function()
      require("treesitter_indent_object.textobj").select_indent_outer()
    end,
    mode = { "x", "o" },
    desc = "Select context-aware indent (outer)"
  },
  { "aI",
    function()
      require("treesitter_indent_object.textobj").select_indent_outer(true, "V")
      require("treesitter_indent_object.refiner").include_surrounding_empty_lines()
    end,
    mode = { "x", "o" },
    desc = "Select context-aware indent (outer, line-wise)"
  },
  { "ii",
    function()
      require("treesitter_indent_object.textobj").select_indent_inner()
    end,
    mode = { "x", "o" },
    desc = "Select context-aware indent (inner, partial range)"
  },
  { "iI",
    function()
      require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
    end,
    mode = { "x", "o" },
    desc = "Select context-aware indent (inner, entire range) in line-wise visual mode"
  },
}
