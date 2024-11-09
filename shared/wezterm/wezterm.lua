--
-- ~/.config/wezterm/wezterm.lua
--

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

return {
  -- bell
  audible_bell = "Disabled",
  visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 50,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 50,
  },

  -- scrollback
  scrollback_lines = 10000,

  -- font
  font_size = 12,
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  adjust_window_size_when_changing_font_size = false,

  --keys
  use_dead_keys = false,
  keys = {
    { key = "t",
      mods = "CMD|SHIFT",
      action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir })
    }
  },

  -- cursor
  default_cursor_style = "BlinkingBar",
  cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 0.0, 0.0 } },
  cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 0.0, 0.0 } },
  cursor_blink_rate = 500,

  -- window
  default_cwd = wezterm.home_dir,
  use_fancy_tab_bar = true,
  window_decorations = "RESIZE",
  window_frame = {
    border_left_width = "0.1cell",
    border_right_width = "0.1cell",
    border_bottom_height = "0.1cell",
    border_top_height = "0.1cell",
    border_left_color = "gray",
    border_right_color = "gray",
    border_bottom_color = "gray",
    border_top_color = "gray",
  },

  -- open in full screen
  wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end),

  -- open links with control or command clicks only
  mouse_bindings = {
    -- control click
    { event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.OpenLinkAtMouseCursor
    },
    -- command click (macOS only)
    { event = { Up = { streak = 1, button = "Left" } },
      mods = "CMD",
      action = act.OpenLinkAtMouseCursor
    },
    -- don't open links without a key modifier
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "",
      action = act.Nop
    }
  },

  -- colorscheme
  colors = {
    foreground = "#cccccc", --white
    background = "#0c0c0c", -- black
    ansi = {
      "#0c0c0c", -- black
      "#c50f1f", -- red
      "#13a10e", -- green
      "#c19c00", -- yellow
      "#0037da", -- blue
      "#881798", -- purple
      "#3a96dd", -- cyan
      "#cccccc"  -- white
    },
    brights = {
      "#767676", -- bright black
      "#e74856", -- bright red
      "#16c60c", -- bright green
      "#f9f1a5", -- bright yellow
      "#3b78ff", -- bright blue
      "#b4009e", -- bright purple
      "#61d6d6", -- bright cyan
      "#dddddd"  -- bright white
    },
    visual_bell = "#101010"
  }
}
