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
  default_prog = {[[C:\\Program Files\\PowerShell\\7\\pwsh.exe]]},
  
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
}
