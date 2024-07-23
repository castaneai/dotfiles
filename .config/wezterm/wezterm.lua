local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'ayu'
config.send_composed_key_when_left_alt_is_pressed = true
config.front_end = 'WebGpu'

wezterm.on('open-uri', function(window, pane, uri)
  -- Do not open `mailto:` link
  local start, match_end = uri:find 'mailto:'
  if start == 1 then
    return false
  end
end)

return config
