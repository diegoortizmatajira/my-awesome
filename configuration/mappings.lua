local awful = require('awful')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local function mapkey(map, handler, help)
  return awful.key(map[1], map[2], handler, help)
end

return {
  client_swap_master = {{modkey}, 'm'},
  client_full_screen = {{modkey}, 'F11'},
  client_close = {{altkey}, 'F4'},
  client_maximize = {{modkey}, 'Prev'},
  client_minimize = {{modkey}, 'Next'},
  client_select_prev = {{modkey}, ','},
  client_select_next = {{modkey}, '.'},
  awesome_restart = {{modkey, 'Control'}, 'r'},
  awesome_quit = {{modkey, 'Control'}, 'q'},
  awesome_help = {{modkey}, 'F1'},
  app_emoji_picker = {{modkey}, 'a'},
  app_nordvpn = {{modkey}, 'g'},
  system_display_layout = {{modkey}, 'p'},
  system_power_options = {{modkey}, 'Delete'},
  system_lock = {{modkey, 'Shift'}, 'l'},
  system_clipboard = {{modkey}, 'v'},
  system_show_desktop = {{modkey}, 'd'},
  system_next_wallpaper = {{modkey, 'Shift'}, 'd'},
  client_select_below = {{modkey}, 'j'},
  client_select_above = {{modkey}, 'k'},
  client_select_left = {{modkey}, 'h'},
  client_select_right = {{modkey}, 'l'},
  client_select_below_alt = {{modkey}, 'Down'},
  client_select_above_alt = {{modkey}, 'Up'},
  client_select_left_alt = {{modkey}, 'Left'},
  client_select_right_alt = {{modkey}, 'Right'},
  mapkey = mapkey
}
