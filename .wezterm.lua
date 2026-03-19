local wezterm = require "wezterm"
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.default_prog = { "pwsh.exe", "-NoLogo" }
config.default_cwd = "C:/oce-dev"
config.scrollback_lines = 20000
config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font "Fira Code"

config.leader = { key = "w", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
  {
    key = "\\",
    mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    key = "LeftArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize { "Left", 1 }
  },
  {
    key = "RightArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize { "Right", 1 }
  },
  {
    key = "UpArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize { "Up", 1 }
  },
  {
    key = "DownArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize { "Down", 1 }
  },
  {
    key = "LeftArrow",
    mods = "LEADER|SHIFT",
    action = act.AdjustPaneSize { "Left", 5 }
  },
  {
    key = "RightArrow",
    mods = "LEADER|SHIFT",
    action = act.AdjustPaneSize { "Right", 5 }
  },
  {
    key = "UpArrow",
    mods = "LEADER|SHIFT",
    action = act.AdjustPaneSize { "Up", 5 }
  },
  {
    key = "DownArrow",
    mods = "LEADER|SHIFT",
    action = act.AdjustPaneSize { "Down", 5 }
  },
  {
    key = "q",
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = false }
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection "Left"
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection "Right"
  },
  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection "Down"
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection "Up"
  },
  {
    key = "LeftArrow",
    mods = "CTRL|ALT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CTRL|ALT",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "F4",
    mods = "CTRL|ALT",
    action = act.CloseCurrentTab { confirm = false },
  },
  {
    key = "x",
    mods = "CTRL|ALT",
    action = act.CloseCurrentTab { confirm = false },
  },
  {
    key = "n",
    mods = "CTRL|ALT",
    action = act.SpawnTab 'CurrentPaneDomain'
  },
  {
    key = "n",
    mods = "CTRL|ALT|SHIFT",
    action = act.ShowLauncher,
  },
  {
    key = "p",
    mods = "LEADER",
    action = act.SpawnCommandInNewTab {
      label = "WezTerm config",
      args = { "nvim", "~/.wezterm.lua" },
      domain = "DefaultDomain",
    }
  },
}
return config
