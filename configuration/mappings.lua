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
  client_close_alt = {{modkey}, 'w'},
  client_maximize = {{modkey}, 'Prior'},
  client_minimize = {{modkey}, 'Next'},
  client_restore_all = {{modkey, 'Shift'}, 'Prior'},
  client_minimize_all = {{modkey, 'Shift'}, 'Next'},
  -- Prev / Next in the workspace
  client_select_prev = {{modkey}, ','},
  client_select_next = {{modkey}, '.'},
  -- Selection by position (Global)
  client_select_below = {{modkey}, 'j'},
  client_select_below_alt = {{modkey}, 'Down'},
  client_select_above = {{modkey}, 'k'},
  client_select_above_alt = {{modkey}, 'Up'},
  client_select_left = {{modkey}, 'h'},
  client_select_left_alt = {{modkey}, 'Left'},
  client_select_right = {{modkey}, 'l'},
  client_select_right_alt = {{modkey}, 'Right'},
  client_select_urgent = {{modkey}, 'u'},
  client_switch = {{altkey}, 'Tab'},
  awesome_restart = {{modkey, 'Control'}, 'r'},
  awesome_quit = {{modkey, 'Control'}, 'q'},
  awesome_help = {{modkey}, 'F1'},
  system_display_layout = {{modkey}, 'p'},
  system_power_options = {{modkey}, 'Delete'},
  system_lock = {{modkey, 'Shift'}, 'l'},
  system_clipboard = {{modkey}, 'v'},
  system_show_desktop = {{modkey}, 'd'},
  system_next_wallpaper = {{modkey, 'Shift'}, 'd'},
  system_screenshot = {{}, 'Print'},
  system_screenshot_region = {{modkey, 'Shift'}, 'Print'},
  system_screenshot_region_alt = {{modkey, 'Shift'}, 's'},
  system_screenshot_ocr = {{altkey}, 'Print'},
  system_search = {{modkey}, 'space'},
  system_launcher = {{modkey, 'Control'}, 'Escape'},
  system_screenshot_delayed = {{'Shift'}, 'Print'},
  workspace_previous = {{modkey, 'Control'}, 'j'},
  workspace_next = {{modkey, 'Control'}, 'k'},
  workspace_previous_alt = {{modkey, 'Control'}, 'Down'},
  workspace_next_alt = {{modkey, 'Control'}, 'Up'},
  workspace_switch = {{modkey}, 'Tab'},
  workspace_resize_layout = {{modkey}, 'r'},
  workspace_relocate = {{modkey, 'Shift'}, 'r'},
  workspace_next_layout = {{altkey}, 'r'},
  workspace_prev_layout = {{altkey, 'Shift'}, 'r'},
  workspace_find_empty = {{modkey}, 'n'},
  app_emoji_picker = {{modkey}, 'a'},
  app_nordvpn = {{modkey}, 'g'},
  app_text_editor = {{modkey}, 't'},
  app_browser = {{modkey}, 'b'},
  app_terminal = {{modkey}, 'x'},
  app_file_explorer = {{modkey}, 'e'},
  app_floating_terminal = {{modkey}, 'z'},
  app_workspace_default = {{modkey}, 'Return'},
  prefix_workspace_goto = {modkey},
  prefix_workspace_moveto = {modkey, 'Shift'},
  prefix_workspace_toggle = {modkey, 'Control'},
  mapkey = mapkey
}
