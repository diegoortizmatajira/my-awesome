local awful = require('awful')
require('awful.autofocus')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
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
  awful.client.focus.global_bydirection(direction)
end

-- Key bindings
local globalKeys = awful.util.table.join( -- Awesome
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'Reload Awesome', group = 'Awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'Quit Awesome', group = 'Awesome'}), -- Hotkeys
  awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'Show help', group = 'Hotkeys'}),
  awful.key({modkey}, ',', hotkeys_popup.show_help, {description = 'Show help', group = 'Hotkeys'}),
  awful.key({modkey}, 'a', spawn('ibus emoji', true), {description = 'Emoji Picker', group = 'Hotkeys'}),
  awful.key({modkey}, 'g', spawn('custom-nordvpn-menu'), {description = 'Nordvpn options', group = 'Hotkeys'}),
  awful.key({modkey}, 'p', spawn('custom-layout'), {description = 'Display Layout options', group = 'Hotkeys'}),
  awful.key({modkey}, 'Delete', spawn('custom-askpoweroptions'), {description = 'Shutdown options', group = 'Hotkeys'}),
  awful.key({modkey}, 'l', spawn(apps.default.lock), {description = 'Lock the screen', group = 'Hotkeys'}),
  awful.key({modkey}, 'v', spawn('custom-clipboard'), {description = 'Recent clipboard', group = 'Hotkeys'}),
  awful.key({modkey, 'Shift'}, 'd', spawn('custom-wallpaper'), {description = 'Next wallpaper', group = 'Hotkeys'}), -- Window Focus
  awful.key({modkey}, 'Down', focus_client('down'), {description = 'Focus window below', group = 'Windows'}),
  awful.key({modkey}, 'Up', focus_client('up'), {description = 'Focus window above', group = 'Windows'}),
  awful.key({modkey}, 'Right', focus_client('right'), {description = 'Focus window on the right', group = 'Windows'}),
  awful.key({modkey}, 'Left', focus_client('left'), {description = 'Focus window on the left', group = 'Windows'}),
  awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'Jump to urgent window', group = 'Windows'}),
  awful.key({altkey}, 'Tab', spawn('custom-alttab'), {description = 'Switch to other window', group = 'Windows'}), -- Navigate workspaces
  awful.key({modkey, 'Control'}, 'Down', awful.tag.viewprev,
    {description = 'Go to previous workspace', group = 'Workspaces'}), awful.key({modkey, 'Control'}, 'Up',
    awful.tag.viewnext, {description = 'Go to next workspace', group = 'Workspaces'}),
  -- awful.key({modkey, 'Ctrl'}, 'Right',
  --     function()
  --         local screen = awful.screen.focused()
  --     end
  --     , {description = 'Move workspace to screen on the right', group = 'Workspaces'}),
  -- awful.key({modkey, 'Ctrl'}, 'Left', awful.tag.viewprev, {description = 'Move workspace to screen on the left', group = 'Workspaces'}),
  awful.key({modkey}, 'Escape', awful.tag.history.restore,
    {description = 'Go to last used workspace', group = 'Workspaces'}), -- Applications
  -- awful.key({modkey}, 'Super_L', function() , function() awful.spawn('custom-launcher') end),
  awful.key({modkey}, 's', spawn('custom-launcher'), {description = 'Application Launcher', group = 'Applications'}),
  awful.key({modkey}, 't', spawn(apps.default.editor), {description = 'Open a text editor', group = 'Applications'}),
  awful.key({modkey}, 'b', spawn(apps.default.browser), {description = 'Open a browser', group = 'Applications'}),
  awful.key({modkey}, 'Return', spawn(apps.default.terminal), {description = 'Open a terminal', group = 'Applications'}),
  awful.key({modkey}, 'x', spawn(apps.default.terminal), {description = 'Open a terminal', group = 'Applications'}),
  awful.key({modkey}, 'e', spawn(apps.default.files), {description = 'File Explorer', group = 'Applications'}),
  awful.key({modkey, 'Shift'}, 'Return', function()
    _G.toggle_quake()
  end, {description = 'Dropdown Terminal', group = 'Applications'}), awful.key({modkey}, 'z', function()
    _G.toggle_quake()
  end, {description = 'Dropdown Terminal', group = 'Applications'}),
  awful.key({modkey, 'Shift'}, 't', spawn(awful.screen.focused().selected_tag.defaultApp, {
    tag = _G.mouse.screen.selected_tag,
    placement = awful.placement.bottom_right
  }), {description = 'Open default program for workspace', group = 'Applications'}), -- Screenshots
  awful.key({'Shift'}, 'Print', spawn(apps.default.delayed_screenshot, true), {
    description = 'Mark an area and screenshot it 10 seconds later (clipboard)',
    group = 'screenshots (clipboard)'
  }), awful.key({}, 'Print', spawn(apps.default.screenshot, true), {
    description = 'Take a screenshot of your active monitor and copy it to clipboard',
    group = 'screenshots (clipboard)'
  }), awful.key({modkey, 'Shift'}, 'Print', spawn(apps.default.region_screenshot, true),
    {description = 'Mark an area and screenshot it to your clipboard', group = 'screenshots (clipboard)'}),
  awful.key({modkey, 'Shift'}, 's', spawn(apps.default.region_screenshot, true),
    {description = 'Mark an area and screenshot it to your clipboard', group = 'screenshots (clipboard)'}),
  -- Layout: Master Size
  awful.key({altkey, 'Shift'}, 'Right', function()
    awful.tag.incmwfact(0.05)
  end, {description = 'Increase master width factor', group = 'Master window size'}),
  awful.key({altkey, 'Shift'}, 'Left', function()
    awful.tag.incmwfact(-0.05)
  end, {description = 'Decrease master width factor', group = 'Master window size'}),
  awful.key({altkey, 'Shift'}, 'Down', function()
    awful.client.incwfact(0.05)
  end, {description = 'Decrease master height factor', group = 'Master window size'}),
  awful.key({altkey, 'Shift'}, 'Up', function()
    awful.client.incwfact(-0.05)
  end, {description = 'Increase master height factor', group = 'Master window size'}), -- Layout: Amounts
  awful.key({modkey, altkey}, 'Up', function()
    awful.tag.incnmaster(1, nil, true)
  end, {description = 'Increase the number of master clients', group = 'Layout Distribution'}),
  awful.key({modkey, altkey}, 'Down', function()
    awful.tag.incnmaster(-1, nil, true)
  end, {description = 'Decrease the number of master clients', group = 'Layout Distribution'}),
  awful.key({modkey, altkey}, 'Right', function()
    awful.tag.incncol(1, nil, true)
  end, {description = 'Increase the number of columns', group = 'Layout Distribution'}),
  awful.key({modkey, altkey}, 'Left', function()
    awful.tag.incncol(-1, nil, true)
  end, {description = 'Decrease the number of columns', group = 'Layout Distribution'}), -- Layout: Select
  awful.key({modkey}, 'space', function()
    awful.layout.inc(1)
  end, {description = 'Select next Layout', group = 'Layout Distribution'}),
  awful.key({modkey, 'Shift'}, 'space', function()
    awful.layout.inc(-1)
  end, {description = 'Select previous Layout', group = 'Layout Distribution'}),
  awful.key({modkey, 'Control'}, 'n', function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      _G.client.focus = c
      c:raise()
    end
  end, {description = 'Restore minimized', group = 'Windows'}), -- Dropdown application
  -- Brightness
  awful.key({}, 'XF86MonBrightnessUp', spawn('xbacklight -inc 10')),
  awful.key({}, 'XF86MonBrightnessDown', spawn('xbacklight -dec 10')), -- ALSA volume control
  awful.key({}, 'XF86AudioRaiseVolume', spawn('amixer -D pulse sset Master 5%+')),
  awful.key({}, 'XF86AudioLowerVolume', spawn('amixer -D pulse sset Master 5%-')),
  awful.key({}, 'XF86AudioMute', spawn('amixer -D pulse set Master 1+ toggle')),
  awful.key({}, 'XF86AudioStop', spawn('playerctl stop')),
  awful.key({}, 'XF86AudioPlay', spawn('playerctl play-pause')),
  awful.key({}, 'XF86AudioPause', spawn('playerctl pause')), awful.key({}, 'XF86AudioNext', spawn('playerctl next')),
  awful.key({}, 'XF86AudioPrev', spawn('playerctl prev')),
  awful.key({}, 'XF86PowerDown', spawn('custom-askpoweroptions')),
  awful.key({}, 'XF86PowerOff', spawn('custom-askpoweroptions')), awful.key({modkey}, 'n', function()
    local screen = awful.screen.focused()
    for _, tag in ipairs(tags) do
      if #tag:clients() == 0 and not tag.selected and #tag.screen.tags > 1 then
        awful.tag.setscreen(screen, tag)
        tag:view_only()
        return
      end
    end
  end, {description = 'Go to new empty workspace', group = 'Workspaces'}), awful.key({modkey, 'Shift'}, 'n', function()
    local screen = awful.screen.focused()
    for _, tag in ipairs(tags) do
      if _G.client.focus and #tag:clients() == 0 and not tag.selected and #tag.screen.tags > 1 then
        awful.tag.setscreen(screen, tag)
        _G.client.focus:move_to_tag(tag)
        tag:view_only()
        return
      end
    end
  end, {description = 'Move window to a new empty workspace', group = 'Workspaces'}) -- Screen management
)

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
  awful.key({modkey}, '#' .. i + 9, function()
    local screen = awful.screen.focused()
    local tag = tags[i]
    if tag then
      -- Only moves empty tags when the screen has more tags
      if #tag:clients() == 0 and not tag.selected and #tag.screen.tags > 1 then awful.tag.setscreen(screen, tag) end
      tag:view_only()
      awful.screen.focus(tag.screen)
    end
  end, descr_view), -- Toggle tag display.
  awful.key({modkey, 'Control'}, '#' .. i + 9, function()
    local tag = tags[i]
    if tag then awful.tag.viewtoggle(tag) end
  end, descr_toggle), -- Move client to tag.
  awful.key({modkey, 'Shift'}, '#' .. i + 9, function()
    if _G.client.focus then
      local tag = tags[i]
      if tag then
        _G.client.focus:move_to_tag(tag)
        tag:view_only()
      end
    end
  end, descr_move))
end

return globalKeys
