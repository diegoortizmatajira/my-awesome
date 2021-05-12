local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local pageUp = '#112'
local pageDown = '#117'
local apps = require('configuration.apps')


-- Key bindings
local globalKeys = awful.util.table.join(
    -- Awesome
    -- awful.key({}, '#133', function() awful.spawn('custom-launcher') end),
    awful.key({modkey}, 's', function() awful.spawn('custom-launcher') end, {description = 'Application Launcher', group = 'Awesome'}),
    awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'Show help', group = 'Awesome'}),
    awful.key({modkey}, ',', hotkeys_popup.show_help, {description = 'Show help', group = 'Awesome'}),
    awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
    awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),
    -- Hotkeys
    awful.key({modkey}, 'a', function() awful.util.spawn_with_shell('ibus emoji') end, {description = 'Emoji Picker', group = 'Hotkeys'}),
    awful.key({modkey}, 'g', function() awful.spawn('custom-nordvpn-menu') end, {description = 'Nordvpn options', group = 'Hotkeys'}),
    awful.key({modkey}, 'p', function() awful.spawn('custom-layout') end, {description = 'Display Layout options', group = 'Hotkeys'}),
    awful.key({modkey}, 'Delete', function() awful.spawn('custom-askpoweroptions') end, {description = 'Shutdown options', group = 'Hotkeys'}),
    awful.key({modkey}, 'l', function() awful.spawn(apps.default.lock) end, {description = 'Lock the screen', group = 'Hotkeys'}),
    -- Window Focus
    awful.key({modkey}, 'Down', function() awful.client.focus.global_bydirection('down') end, {description = 'Focus window below', group = 'Windows'}),
    awful.key({modkey}, 'Up', function() awful.client.focus.global_bydirection('up') end, {description = 'Focus window above', group = 'Windows'}),
    awful.key({modkey}, 'Right', function() awful.client.focus.global_bydirection('right') end, {description = 'Focus window on the right', group = 'Windows'}),
    awful.key({modkey}, 'Left', function() awful.client.focus.global_bydirection('left') end, {description = 'Focus window on the left', group = 'Windows'}),
    -- Modkey + Shift
    awful.key({modkey, 'Shift'}, pageDown, awful.tag.viewprev, {description = 'Change to previous workspace', group = 'Workspaces'}),
    awful.key({modkey, 'Shift'}, pageUp, awful.tag.viewnext, {description = 'Change to next workspace', group = 'Workspaces'}),
    awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'Change to last used workspace', group = 'Workspaces'}),
    -- Default Window focus
    awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'Windows'}),
    awful.key({altkey}, 'Tab', function() awful.spawn('custom-alttab') end, {description = 'Switch to other window', group = 'Windows'}),
    -- Programs
    awful.key({modkey}, 'c', function() awful.util.spawn(apps.default.editor) end, {description = 'Open a text/code editor', group = 'Applications'}),
    awful.key({modkey}, 'b', function() awful.util.spawn(apps.default.browser) end, {description = 'Open a browser', group = 'Applications'}),
    awful.key({'Shift'}, 'Print', function() awful.util.spawn_with_shell(apps.default.delayed_screenshot) end, {description = 'Mark an area and screenshot it 10 seconds later (clipboard)', group = 'screenshots (clipboard)'}),
    awful.key({}, 'Print', function() awful.util.spawn_with_shell(apps.default.screenshot) end, {description = 'Take a screenshot of your active monitor and copy it to clipboard', group = 'screenshots (clipboard)'}),
    awful.key({modkey, 'Shift'}, 'Print', function() awful.util.spawn_with_shell(apps.default.region_screenshot) end, {description = 'Mark an area and screenshot it to your clipboard', group = 'screenshots (clipboard)'}),
    -- Standard program
    awful.key({modkey}, 'Return', function() awful.spawn(apps.default.terminal) end, {description = 'Open a terminal', group = 'Applications'}),
    awful.key({modkey}, 'x', function() awful.spawn(apps.default.terminal) end, {description = 'Open a terminal', group = 'Applications'}),
    awful.key({altkey, 'Shift'}, 'Right', function() awful.tag.incmwfact(0.05) end, {description = 'Increase master width factor', group = 'layout'}),
    awful.key({altkey, 'Shift'}, 'Left', function() awful.tag.incmwfact(-0.05) end, {description = 'Decrease master width factor', group = 'layout'}),
    awful.key({altkey, 'Shift'}, 'Down', function() awful.client.incwfact(0.05) end, {description = 'Decrease master height factor', group = 'layout'}),
    awful.key({altkey, 'Shift'}, 'Up', function() awful.client.incwfact(-0.05) end, {description = 'Increase master height factor', group = 'layout'}),
    awful.key({modkey, 'Shift'}, 'Left', function() awful.tag.incnmaster(1, nil, true) end, {description = 'Increase the number of master clients', group = 'layout'}),
    awful.key({modkey, 'Shift'}, 'Right', function() awful.tag.incnmaster(-1, nil, true) end, {description = 'Decrease the number of master clients', group = 'layout'}),
    awful.key({modkey, 'Control'}, 'Left', function() awful.tag.incncol(1, nil, true) end, {description = 'Increase the number of columns', group = 'layout'}),
    awful.key({modkey, 'Control'}, 'Right', function() awful.tag.incncol(-1, nil, true) end, {description = 'Decrease the number of columns', group = 'layout'}),
    awful.key({modkey}, 'space', function() awful.layout.inc(1) end, {description = 'Select next Layout', group = 'layout'}),
    awful.key({modkey, 'Shift'}, 'space', function() awful.layout.inc(-1) end, {description = 'Select previous Layout', group = 'layout'}),
    awful.key({modkey, 'Control'}, 'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                _G.client.focus = c
                c:raise()
            end
        end,
        {description = 'Restore minimized', group = 'Windows'}),
    -- Dropdown application
    awful.key({modkey, 'Shift'}, 'Return', function() _G.toggle_quake() end, {description = 'Dropdown Terminal', group = 'Applications'}),
    awful.key({modkey}, 'z', function() _G.toggle_quake() end, {description = 'Dropdown Terminal', group = 'Applications'}),
    -- Brightness
    awful.key({}, 'XF86MonBrightnessUp', function() awful.spawn('xbacklight -inc 10') end),
    awful.key({}, 'XF86MonBrightnessDown', function() awful.spawn('xbacklight -dec 10') end),
    -- ALSA volume control
    awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn('amixer -D pulse sset Master 5%+') end),
    awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn('amixer -D pulse sset Master 5%-') end),
    awful.key({}, 'XF86AudioMute', function() awful.spawn('amixer -D pulse set Master 1+ toggle') end),
    awful.key({}, 'XF86AudioStop', function() awful.spawn('playerctl stop') end),
    awful.key({}, 'XF86AudioPlay', function() awful.spawn('playerctl play-pause') end),
    awful.key({}, 'XF86AudioPause', function() awful.spawn('playerctl pause') end),
    awful.key({}, 'XF86AudioNext', function() awful.spawn('playerctl next') end),
    awful.key({}, 'XF86AudioPrev', function() awful.spawn('playerctl prev') end),
    awful.key({}, 'XF86PowerDown', function() awful.spawn('custom-askpoweroptions') end),
    awful.key({}, 'XF86PowerOff', function() awful.spawn('custom-askpoweroptions') end),
    -- Screen management
    -- awful.key({modkey}, 'Right', awful.client.movetoscreen, {description = 'move window to next screen', group = 'Windows'}),
    -- Open default program for tag
    awful.key({modkey}, 't',
        function()
            awful.spawn(
                awful.screen.focused().selected_tag.defaultApp,
                {
                    tag = _G.mouse.screen.selected_tag,
                    placement = awful.placement.bottom_right
                }
            )
        end, {description = 'Open default program for tag/workspace', group = 'Tag'}
    ),
    -- Custom hotkeys
    -- File Manager
    awful.key({modkey}, 'e', function() awful.util.spawn(apps.default.files) end, {description = 'File Explorer', group = 'Programs'})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = 'view tag #', group = 'Tag'}
        descr_toggle = {description = 'toggle tag #', group = 'Tag'}
        descr_move = {description = 'move focused client to tag #', group = 'Tag'}
        descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'Tag'}
    end
    globalKeys =
        awful.util.table.join(
            globalKeys,
            -- View tag only.
            awful.key(
                {modkey},
                '#' .. i + 9,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end,
                descr_view
            ),
            -- Toggle tag display.
            awful.key(
                {modkey, 'Control'},
                '#' .. i + 9,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end,
                descr_toggle
            ),
            -- Move client to tag.
            awful.key(
                {modkey, 'Shift'},
                '#' .. i + 9,
                function()
                    if _G.client.focus then
                        local tag = _G.client.focus.screen.tags[i]
                        if tag then
                            _G.client.focus:move_to_tag(tag)
                        end
                    end
                end,
                descr_move
            ),
            -- Toggle tag on focused client.
            awful.key(
                {modkey, 'Control', 'Shift'},
                '#' .. i + 9,
                function()
                    if _G.client.focus then
                        local tag = _G.client.focus.screen.tags[i]
                        if tag then
                            _G.client.focus:toggle_tag(tag)
                        end
                    end
                end,
                descr_toggle_focus
            )
        )
end

return globalKeys
