-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font config
config.font = wezterm.font 'NotoSansM Nerd Font'
config.font_size = 11.0

-- Disable window decorations (titlebar and border around window)
config.window_decorations = "NONE"

-- Disable the ugly padding inside border
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Disable tab bar
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- and finally, return the configuration to wezterm
return config
