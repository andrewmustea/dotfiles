#!/usr/bin/env lua

--
-- nvim/lua/config/bufferline.lua
--

-- https://github.com/akinsho/bufferline.nvim

local fn = vim.fn
local map = vim.keymap.set

local black      = "#0c0c0c"
local black_gray = "#151515"
local dusk       = "#202020"
local steel_gray = "#606060"
local white_gray = "#aaaaaa"
local blue_gray  = "#4f5b66"
local dark_blue  = "#042a4a"
local sage       = "#508040"
local red        = "#b02828"

require("bufferline").setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = function(opts)
      local winlist = fn.win_findbuf(tonumber(opts.id))
      if next(winlist) then
        local tablist = fn.win_id2tabwin(winlist[1])
        if next(tablist) then
          return ""
        end
      end
      return string.format("(%s)", opts.id)
    end,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      { filetype = "NvimTree",
        highlight = "Directory",
        text_align = "left"
      }
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    sort_by = "tabs",
  },
  highlights = {
    background             = { fg = blue_gray,  bg = black_gray },
    buffer                 = { fg = blue_gray,  bg = black_gray },
    buffer_selected        = { fg = white_gray, bg = dark_blue,    bold = false, italic = false },
    buffer_visible         = { fg = steel_gray, bg = dusk },
    close_button           = { fg = blue_gray,  bg = black_gray },
    close_button_selected  = { fg = white_gray, bg = dark_blue },
    close_button_visible   = { fg = steel_gray, bg = dusk },
    -- diagnostic                  = { },
    -- diagnostic_selected         = { },
    -- diagnostic_visible          = { },
    duplicate              = { fg = blue_gray,  bg = black_gray },
    duplicate_selected     = { fg = white_gray, bg = dark_blue },
    duplicate_visible      = { fg = steel_gray, bg = dusk },
    -- error                       = { },
    -- error_selected              = { },
    -- error_visible               = { },
    -- error_diagnostic            = { },
    -- error_diagnostic_selected   = { },
    -- error_diagnostic_visible    = { },
    fill                   = { bg = black },
    -- hint                        = { },
    -- hint_selected               = { },
    -- hint_visible                = { },
    -- hint_diagnostic             = { },
    -- hint_diagnostic_selected    = { },
    -- hint_diagnostic_visible     = { },
    -- indicator_selected          = { },
    -- indicator_visible           = { },
    -- info                        = { },
    -- info_selected               = { },
    -- info_visible                = { },
    -- info_diagnostic             = { },
    -- info_diagnostic_selected    = { },
    -- info_diagnostic_visible     = { },
    modified               = { fg = sage,       bg = black_gray },
    modified_selected      = { fg = sage,       bg = dark_blue },
    modified_visible       = { fg = sage,       bg = dusk },
    numbers                = { fg = blue_gray,  bg = black_gray },
    numbers_selected       = { fg = white_gray, bg = dark_blue,    bold = true, italic = false },
    numbers_visible        = { fg = steel_gray, bg = dusk },
    -- offset_separator            = { },
    pick                   = { fg = red,        bg = black_gray,   bold = true, italic = false },
    pick_selected          = { fg = red,        bg = dark_blue,    bold = true, italic = false },
    pick_visible           = { fg = red,        bg = dusk,         bold = true, italic = false },
    separator              = { fg = black,      bg = black_gray },
    separator_selected     = { fg = black,      bg = dark_blue },
    separator_visible      = { fg = black,      bg = dusk },
    tab                    = { fg = blue_gray,  bg = black },
    tab_close              = { fg = white_gray, bg = black },
    tab_selected           = { fg = white_gray, bg = dark_blue },
    tab_separator          = { fg = black,      bg = black },
    tab_separator_selected = { fg = dark_blue,  bg = black,        sp = "",     underline = false },
    -- warning                     = { },
    -- warning_selected            = { },
    -- warning_visible             = { }
    -- warning_diagnostic          = { },
    -- warning_diagnostic_selected = { },
    -- warning_diagnostic_visible  = { },
  }
})

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map("n", "[b", ":BufferLineCycleNext<CR>", { silent = true, noremap = true })
map("n", "]b", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true })

-- Buffer selection
map("n", "gb", ":BufferLinePick<CR>", { silent = true, noremap = true })

map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true, noremap = true })
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true, noremap = true })
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true, noremap = true })
map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true, noremap = true })
map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true, noremap = true })
map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true, noremap = true })
map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true, noremap = true })
map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true, noremap = true })
map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { silent = true, noremap = true })
