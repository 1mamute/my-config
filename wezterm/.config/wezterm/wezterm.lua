-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Theme
config.color_scheme = 'OneDark (base16)'

-- Title bar
config.window_decorations = "RESIZE"

-- Padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true -- already the default

-- Fonts
config.font = wezterm.font_with_fallback {
  {
    family = 'Fira Code',
    harfbuzz_features = {
      'calt=0', 'clig=0', 'liga=0', -- no ligatures
      'cv02',                       -- change the g
    },
  },
  {
    family = 'FiraCode Nerd Font Mono',
    harfbuzz_features = {
      'calt=0', 'clig=0', 'liga=0', -- no ligatures
      'cv02',                       -- change the g
    },
  }
}

-- Underline
config.underline_position = -3
config.underline_thickness = 2

-- Hyperlinks
-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

-- Keymaps
local act = wezterm.action
config.keys = {
  {
    key = 'w',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'splits',
      one_shot = true,
    },
  },
  -- disable all default keybindings using SUPER
  { key = '-', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '0', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '1', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '2', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '3', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '4', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '5', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '6', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '7', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '8', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '9', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '=', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '[', mods = 'SHIFT|SUPER',                            action = wezterm.action.DisableDefaultAssignment },
  { key = ']', mods = 'SHIFT|SUPER',                            action = wezterm.action.DisableDefaultAssignment },
  { key = 'c', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'f', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'k', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'm', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'n', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'r', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 't', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'v', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = 'w', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '{', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '{', mods = 'SHIFT|SUPER',                            action = wezterm.action.DisableDefaultAssignment },
  { key = '}', mods = 'SUPER',                                  action = wezterm.action.DisableDefaultAssignment },
  { key = '}', mods = 'SHIFT|SUPER',                            action = wezterm.action.DisableDefaultAssignment },
}

config.key_tables = {
  splits = {
    { key = 'w', action = act.CloseCurrentPane { confirm = true } },
    -- vim bindings and arrow keys to focus split panels
    { key = 'k', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    -- vim bindings and arrow keys to split panes
    { key = 'k', mods = 'ALT', action = act.SplitPane { direction = 'Up' } },
    { key = 'j', mods = 'ALT', action = act.SplitPane { direction = 'Down' } },
    { key = 'l', mods = 'ALT', action = act.SplitPane { direction = 'Right' } },
    { key = 'h', mods = 'ALT', action = act.SplitPane { direction = 'Left' } },
    { key = 'UpArrow', mods = 'ALT', action = act.SplitPane { direction = 'Up' } },
    { key = 'DownArrow', mods = 'ALT', action = act.SplitPane { direction = 'Down' } },
    { key = 'RightArrow', mods = 'ALT', action = act.SplitPane { direction = 'Right' } },
    { key = 'LeftArrow', mods = 'ALT', action = act.SplitPane { direction = 'Left' } },
  },
}

return config
