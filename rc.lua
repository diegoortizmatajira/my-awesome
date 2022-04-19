-- luacheck: globals root

local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local gears = require('gears')

-- Theme
beautiful.init(require('theme'))

-- Layout
require('layout')

-- Init all modules
require('module.notifications')
require('module.auto-start')
require('module.decorate-client')
-- Backdrop causes bugs on some gtk3 applications
-- require('module.backdrop')
require('module.exit-screen')
require('module.quake-terminal')

-- Setup all configurations
require('configuration.client')
require('configuration.tags')


root.keys(require('configuration.keys.global'))

-- {{{ Screen
-- Reset wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal( "property::geometry", function(s) beautiful.wallpaper.maximized( beautiful.wallpaper, s, beautiful.wallpapers) end )

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    -- Adds a default icon to the client if it doesn't exist'
    local cairo = require("lgi").cairo
    local default_icon = "/usr/share/icons/default.svg"
    if c and c.valid and not c.icon then
        local s = gears.surface(default_icon)
        local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
        local cr = cairo.Context(img)
        cr:set_source_surface(s, 0, 0)
        cr:paint()
        c.icon = img._native
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
--[[
_G.client.connect_signal(
'mouse::enter',
function(c)
c:emit_signal('request::activate', 'mouse_enter', {raise = true})
end
)
--]]

-- Make the focused window have a glowing border
client.connect_signal('focus', function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
    c.border_color = beautiful.border_normal
end)
-- Run garbage collector regularly to prevent memory leaks
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function() collectgarbage() end
}
