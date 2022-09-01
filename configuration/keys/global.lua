local awful = require('awful')
local mappings = require('configuration.mappings')
local mapkey = mappings.mapkey
local modalbind = require("configuration.keys.modal-binding")
modalbind.init()

local MOVE_TO_CURRENT_DISPLAY = false

require('awful.autofocus')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local apps = require('configuration.apps')
local tags = require('configuration.tags')

local function spawn(app, with_shell)
  return function()
    if with_shell == true then
      awful.util.spawn_with_shell(app)
    else
      awful.spawn(app)
    end
  end
end

local function focus_client(direction)
  return function()
    awful.client.focus.global_bydirection(direction)
  end
end

local function toggle_minimize_all(minimized)
  return function()
    -- luacheck: globals mouse
    for _, c in ipairs(mouse.screen.selected_tag:clients()) do c.minimized = minimized end
  end
end

local function move_tag_to_screen(relative)
  local t = client.focus and client.focus.first_tag or nil
  if t == nil then return end
  awful.screen.focus_bydirection(relative, t.screen)
  t.screen = awful.screen.focused()
  awful.tag.viewonly(t)
end

local screen_move_map = {
  {
    "h",
    function()
      move_tag_to_screen('left')
    end,
    "Move to screen on the left"
  },
  {
    "l",
    function()
      move_tag_to_screen('right')
    end,
    "Move to screen on the right"
  },
  {
    "k",
    function()
      move_tag_to_screen('up')
    end,
    "Move to screen above"
  },
  {
    "j",
    function()
      move_tag_to_screen('down')
    end,
    "Move to screen below"
  }
}

local layout_modify_map = {
  {
    "h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    "Decrease Master Size"
  },
  {
    "l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    "Increase Master Size"
  },
  {
    "j",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    "Decrease Master Count"
  },
  {
    "k",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    "Increase Master Count"
  },
  {
    "u",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    "Decrease Column Count"
  },
  {
    "i",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    "Increase Column Count"
  }
}

-- Key bindings
local globalKeys = awful.util.table.join( -- Awesome
  mapkey(mappings.awesome_restart, awesome.restart, {description = 'Reload Awesome', group = 'Awesome'}),
  mapkey(mappings.awesome_quit, awesome.quit, {description = 'Quit Awesome', group = 'Awesome'}), -- Hotkeys
  mapkey(mappings.awesome_help, hotkeys_popup.show_help, {description = 'Show help', group = 'Hotkeys'}),
  mapkey(mappings.system_show_desktop, toggle_minimize_all(true), {description = 'Show desktop', group = 'Hotkeys'}),
  mapkey(mappings.client_select_below, focus_client('down'), {description = 'Focus window below', group = 'Windows'}),
  mapkey(mappings.client_select_above, focus_client('up'), {description = 'Focus window above', group = 'Windows'}),
  mapkey(mappings.client_select_right, focus_client('right'),
    {description = 'Focus window on the right', group = 'Windows'}), --
  mapkey(mappings.client_select_left, focus_client('left'),
    {description = 'Focus window on the left', group = 'Windows'}), mapkey(mappings.client_select_below_alt,
    focus_client('down'), {description = 'Focus window below', group = 'Windows'}), mapkey(
    mappings.client_select_above_alt, focus_client('up'), {description = 'Focus window above', group = 'Windows'}),
  mapkey(mappings.client_select_right_alt, focus_client('right'),
    {description = 'Focus window on the right', group = 'Windows'}),
  mapkey(mappings.client_select_left_alt, focus_client('left'),
    {description = 'Focus window on the left', group = 'Windows'}),
  mapkey(mappings.client_select_urgent, awful.client.urgent.jumpto,
    {description = 'Jump to urgent window', group = 'Windows'}), --
  mapkey(mappings.client_switch, spawn('custom-alttab'), {description = 'Switch to other window', group = 'Windows'}), -- Navigate workspaces
  mapkey(mappings.workspace_previous, awful.tag.viewprev,
    {description = 'Go to previous workspace', group = 'Workspaces'}), --
  mapkey(mappings.workspace_next, awful.tag.viewnext, {description = 'Go to next workspace', group = 'Workspaces'}),
  mapkey(mappings.workspace_previous_alt, awful.tag.viewprev,
    {description = 'Go to previous workspace', group = 'Workspaces'}), --
  mapkey(mappings.workspace_next_alt, awful.tag.viewnext, {description = 'Go to next workspace', group = 'Workspaces'}),
  mapkey(mappings.workspace_switch, awful.tag.history.restore,
    {description = 'Go to last used workspace', group = 'Workspaces'}), -- Applications
  mapkey(mappings.app_workspace_default, spawn(awful.screen.focused().selected_tag.defaultApp),
    {description = 'Open default program for workspace', group = 'Applications'}), -- Screenshots
  -- Layout: Master Size
  mapkey(mappings.workspace_resize_layout, function()
    modalbind.grab({keymap = layout_modify_map, name = 'Modify layout', stay_in_mode = true})
  end, {description = 'Resizes the current layout', group = 'Modes'}), -- Layout: Move tags to different screen
  mapkey(mappings.workspace_relocate, function()
    modalbind.grab({keymap = screen_move_map, name = 'Move current tag to screen', stay_in_mode = true})
  end, {description = 'Relocate current Tag', group = 'Modes'}), --
  mapkey(mappings.workspace_next_layout, function()
    awful.layout.inc(1)
  end, {description = 'Select next Layout', group = 'Layout Distribution'}),
  mapkey(mappings.workspace_prev_layout, function()
    awful.layout.inc(-1)
  end, {description = 'Select previous Layout', group = 'Layout Distribution'}),
  mapkey(mappings.client_restore_all, toggle_minimize_all(false),
    {description = 'Restore all windows', group = 'Windows'}), --
  mapkey(mappings.client_minimize_all, toggle_minimize_all(true), {description = 'Restore minimized', group = 'Windows'}), -- Dropdown application
  -- Brightness
  awful.key({}, 'XF86MonBrightnessUp', spawn('xbacklight -inc 10')),
  awful.key({}, 'XF86MonBrightnessDown', spawn('xbacklight -dec 10')), -- ALSA volume control
  awful.key({}, 'XF86AudioRaiseVolume', spawn('amixer -D pulse sset Master 5%+')),
  awful.key({}, 'XF86AudioLowerVolume', spawn('amixer -D pulse sset Master 5%-')),
  awful.key({}, 'XF86AudioMute', spawn('amixer -D pulse set Master 1+ toggle')),
  awful.key({}, 'XF86AudioStop', spawn('playerctl stop')),
  awful.key({}, 'XF86AudioPlay', spawn('playerctl play-pause')),
  awful.key({}, 'XF86AudioPause', spawn('playerctl pause')), --
  awful.key({}, 'XF86AudioNext', spawn('playerctl next')), --
  awful.key({}, 'XF86AudioPrev', spawn('playerctl prev')),
  awful.key({}, 'XF86PowerDown', spawn('custom-askpoweroptions')),
  awful.key({}, 'XF86PowerOff', spawn('custom-askpoweroptions')), --
  mapkey(mappings.workspace_find_empty, function()
    local screen = awful.screen.focused()
    for _, tag in ipairs(tags) do
      if #tag:clients() == 0 and not tag.selected then
        if MOVE_TO_CURRENT_DISPLAY and #tag.screen.tags > 1 then
          awful.tag.setscreen(screen, tag)
          tag:view_only()
          return
        else
          if tag.screen.index == screen.index then
            tag:view_only()
            return
          end
        end
      end
    end
  end, {description = 'Go to new empty workspace', group = 'Workspaces'}), awful.key({modkey, 'Shift'}, 'n', function()
    local screen = awful.screen.focused()
    for _, tag in ipairs(tags) do
      if client.focus and #tag:clients() == 0 and not tag.selected then
        if MOVE_TO_CURRENT_DISPLAY and #tag.screen.tags > 1 then
          awful.tag.setscreen(screen, tag)
          client.focus:move_to_tag(tag)
          tag:view_only()
          return
        else
          if tag.screen.index == screen.index then
            client.focus:move_to_tag(tag)
            tag:view_only()
            return
          end
        end
      end
    end
  end, {description = 'Move window to a new empty workspace', group = 'Workspaces'}) -- Screen management
)

local function Change_to_tag_i(i)
  return function()
    local screen = awful.screen.focused()
    local tag = tags[i]
    if tag then
      if MOVE_TO_CURRENT_DISPLAY and #tag:clients() == 0 and not tag.selected and #tag.screen.tags > 1 then
        awful.tag.setscreen(screen, tag)
      end
      tag:view_only()
      awful.screen.focus(tag.screen)
    end
  end
end

local function Toggle_tag_i(i)
  return function()
    local tag = tags[i]
    if tag then awful.tag.viewtoggle(tag) end
  end
end

local function Move_to_tag_i(i)
  return function()
    if client.focus then
      local tag = tags[i]
      if tag then
        client.focus:move_to_tag(tag)
        tag:view_only()
      end
    end
  end
end
local np_map = {87, 88, 89, 83, 84, 85, 79, 80, 81, 90}
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move
  if i == 1 or i == 10 then
    descr_view = {description = 'Focus workspace #', group = 'Workspaces'}
    descr_toggle = {description = 'Toggle tag visibility #', group = 'Workspaces'}
    descr_move = {description = 'Move focused window to workspace #', group = 'Workspaces'}

  end
  globalKeys = awful.util.table.join(globalKeys, -- View tag only.
  awful.key(mappings.prefix_workspace_goto, '#' .. i + 9, Change_to_tag_i(i), descr_view), -- Toggle tag display.
  awful.key(mappings.prefix_workspace_goto, '#' .. np_map[i], Change_to_tag_i(i), descr_view), -- Toggle tag display.
  awful.key(mappings.prefix_workspace_toggle, '#' .. i + 9, Toggle_tag_i(i), descr_toggle), -- Move client to tag.
  awful.key(mappings.prefix_workspace_toggle, '#' .. np_map[i], Toggle_tag_i(i), descr_toggle), -- Move client to tag.
  awful.key(mappings.prefix_workspace_moveto, '#' .. i + 9, Move_to_tag_i(i), descr_move), --
  awful.key(mappings.prefix_workspace_moveto, '#' .. np_map[i], Move_to_tag_i(i), descr_move))
end

return globalKeys
