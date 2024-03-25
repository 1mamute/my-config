-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Theme
config.color_scheme = 'OneDark (base16)'

-- Title bar
config.window_decorations = "RESIZE"
-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true -- already the default

-- Fonts
config.font = wezterm.font_with_fallback {
  {
    family = 'Fira Code',
    harfbuzz_features = {
      'calt=0', 'clig=0', 'liga=0', -- no ligatures
      'cv02', -- change the g
    },
  },
  {
    family = 'FiraCode Nerd Font Mono',
    harfbuzz_features = {
      'calt=0', 'clig=0', 'liga=0', -- no ligatures
      'cv02', -- change the g
    },
  }
}

-- Underline
config.underline_position = -3
config.underline_thickness = 2

-- Keymaps
local act = wezterm.action
config.keys = {
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab{ confirm = true } },
  { key = 'w', mods = 'CTRL|SHIFT|ALT', action = act.CloseCurrentPane{ confirm = true } },
  -- vim bindings to focus panels
  { key = 'k', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'l', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'h', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  -- vim bindings to split panes
  { key = 'k', mods = 'CTRL|SHIFT|ALT', action = act.SplitPane { direction = 'Up' } },
  { key = 'j', mods = 'CTRL|SHIFT|ALT', action = act.SplitPane { direction = 'Down' } },
  { key = 'l', mods = 'CTRL|SHIFT|ALT', action = act.SplitPane { direction = 'Right' } },
  { key = 'h', mods = 'CTRL|SHIFT|ALT', action = act.SplitPane { direction = 'Left' } },
}

return config
