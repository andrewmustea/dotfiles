--
-- ~/.config/wezterm/wezterm.lua
--

local wezterm = require("wezterm")
local mux = wezterm.mux
local config = { }

-- bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 50,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 50,
}

-- scrollback
config.scrollback_lines = 10000

-- font
config.font_size = 12
config.font = wezterm.font("CaskaydiaCove Nerd Font")

-- cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 0.0, 0.0 } }
config.cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 0.0, 0.0 } }
config.cursor_blink_rate = 750

-- window
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"
config.window_frame = {
  border_left_width = "0.1cell",
  border_right_width = "0.1cell",
  border_bottom_height = "0.1cell",
  border_top_height = "0.1cell",
  border_left_color = "gray",
  border_right_color = "gray",
  border_bottom_color = "gray",
  border_top_color = "gray",
}

-- open in full screen
wezterm.on("gui-startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- open links with control or command clicks only
config.mouse_bindings = {
  -- control click
  { event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor
  },
  -- command click (macOS only)
  { event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = wezterm.action.OpenLinkAtMouseCursor
  },
  -- don't open links without a key modifier
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "",
    action = wezterm.action.Nop
  }
}

-- colorscheme
local black         = "#0c0c0c"
local red           = "#c50f1f"
local green         = "#13a10e"
local yellow        = "#c19c00"
local blue          = "#0037da"
local purple        = "#881798"
local cyan          = "#3a96dd"
local white         = "#cccccc"
local bright_black  = "#767676"
local bright_red    = "#e74856"
local bright_green  = "#16c60c"
local bright_yellow = "#f9f1a5"
local bright_blue   = "#3b78ff"
local bright_purple = "#b4009e"
local bright_cyan   = "#61d6d6"
local bright_white  = "#dddddd"
config.colors = {
  foreground = white,
  background = black,
  ansi = {
    black,
    red,
    green,
    yellow,
    blue,
    purple,
    cyan,
    white
  },
  brights = {
    bright_black,
    bright_red,
    bright_green,
    bright_yellow,
    bright_blue,
    bright_purple,
    bright_cyan,
    bright_white
  },
  visual_bell = "#101010"
}

return config
