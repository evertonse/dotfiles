-- Resource : https://wezfurlong.org/wezterm/colorschemes/v/index.html

local wezterm = require 'wezterm'

-- wezterm.on('toggle-ligature', function(window, pane)
--   local overrides = window:get_config_overrides() or {}
--   if not overrides.harfbuzz_features then
--     -- If we haven't overridden it yet, then override with ligatures disabled
--     overrides.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
--   else
--     -- else we did already, and we should disable out override now
--     overrides.harfbuzz_features = nil
--   end
--   window:set_config_overrides(overrides)
-- end)
--
return {
  -- Run any program with default args
  --default_prog = {'C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0\\powershell.exe'},
  --default_prog = {[[C:\\Program Files\\PowerShell\\7\\pwsh.exe]], '-NoLogo'}, -- Powershell 7.+
  default_prog = {[[C:\\Program Files\\PowerShell\\7\\pwsh.exe]], 
    '-NoLogo','-noe','-c',
   [[&{Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell ccb1610a}]] },


  window_background_opacity = 0.92,
  font = wezterm.font 'MesloLGS NF',
  --font = wezterm.font 'Consolas',
  --color_scheme = 'Batman',
  color_scheme = "Vacuous 2 (terminal.sexy)",
  window_close_confirmation = 'NeverPrompt',
  cursor_blink_rate = 350,
  window_padding = {
    left    = '0px',
    right   = '0px',
    top     = '0px',
    bottom  = '0px',
  }, 
  set_environment_variables = {
    -- This changes the default prompt for cmd.exe to report the
    -- current directory using OSC 7, show the current time and
    -- the current directory colored in the prompt.
    --prompt = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ',
  },
  window_decorations = "RESIZE", -- RESIZE|NONE|TITLE
  window_frame = {
    border_left_width     = '0px',
    border_right_width    = '0px',
    border_bottom_height  = '0px',
    border_top_height     = '0px',
  },
  colors = {
    -- The default text color
    --foreground = 'silver',
    -- The default background color
    --background = 'black',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    --cursor_bg = '#52ad70',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = 'black',
    cursor_bg = '#52ad70',
    cursor_border = '#52ad70',
    -- the foreground color of selected text
    selection_fg = 'black',
    -- the background color of selected text
    selection_bg = '#fffacd',
    copy_mode_active_highlight_bg = { Color = '#000000' },
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
  },
  default_cwd = "D:",
  launch_menu = { 
	{ args = { [[C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat]] }
	}
   },
}
