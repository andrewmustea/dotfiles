#!/usr/bin/env lua

--
-- nvim/lua/configs/substitute.lua
--

-- https://github.com/gbprod/substitute.nvim

require("substitute").setup({
  on_substitute = function(event)
    require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV]"))
  end
})
