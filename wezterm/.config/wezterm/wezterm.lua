local wezterm = require('wezterm')

local is_wsl = wezterm.target_triple == 'x86_64-pc-windows-msvc'
local is_macos = wezterm.target_triple == 'aarch64-apple-darwin' or
wezterm.target_triple == 'x86_64-apple-darwin'

local config = wezterm.config_builder()

config = {
  ---------- appearance ----------
  -- tab bar, title bar, scroll bar, padding
  tab_max_width = 100,
  enable_tab_bar = true,
  -- make the tab bar better-looking
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  -- no title bar, which is very ugly
  window_decorations = 'RESIZE',
  enable_scroll_bar = true,     -- where is my scroll bar?
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },

  -- background
  window_background_opacity = 0.7,
  text_background_opacity = 0.55,
  macos_window_background_blur = 20,

  -- better rendering
  enable_kitty_graphics = true,
  front_end = "WebGpu",

  -- font
  font = wezterm.font_with_fallback({
    'Consolas',
    'LXGW Wenkai GB',
    'Fira Code',
  }),
  font_size = 14.0,

  -- other config
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation = 'NeverPrompt',

  -- theme
  color_scheme = 'Dracula (Official)',

  ---------- key bindings ----------
  keys = {
    -- Mac has this function
    -- { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
    -- { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
    { key = 'Enter', mods = 'ALT', action = wezterm.action.ToggleFullScreen },
    { key = "Escape", mods = "ALT", action = wezterm.action.ActivateCopyMode },
    -- { key = '<++>', modes = '<++>', action = <++> },
    -- { key = '<++>', modes = '<++>', action = <++> },
    -- { key = '<++>', modes = '<++>', action = <++> },
  },
}

-- set default program and working directory based on platform
if is_wsl then
  config.default_prog = { 'wsl.exe', '-d', 'Ubuntu', '/usr/bin/bash', '-l' }
  config.default_cwd = '/home/ac/'
elseif is_macos then
  config.default_prog = { '/bin/zsh', '-l' }
  config.default_cwd = '/Users/ac/'
end


---------- window appearance settings ----------

-- initial window position & size, stay in the middle
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local width, height = screen.width * 0.5, screen.height * 0.5
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {
    position = {
      x = (screen.width - width) / 2,
      y = (screen.height - height) / 2,
      origin = {Named=screen.name}
    }
  })
  window:gui_window():set_inner_size(width, height)
end)

return config
