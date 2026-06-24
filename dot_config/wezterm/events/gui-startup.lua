local wt = require "wezterm"

wt.on("gui-startup", function(cmd)
  local _, _, window = wt.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)
