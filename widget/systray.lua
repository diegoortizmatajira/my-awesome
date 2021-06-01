local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local font_icons = require('layout.font-icons')
local dpi = require('beautiful').xresources.apply_dpi

local systray = {base_size = 20, opacity = 1.0, visible = true, widget = wibox.widget.systray}
local tray_container = {
    {
        {
            systray,
            layout = wibox.layout.fixed.horizontal
        },
        top = dpi(7),
        left = dpi(8),
        right = dpi(8),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_systray,
    widget = wibox.container.background
}

local function Systray(color)
    local toggle_systray = font_icons.make_faicon(font_icons.toggle, color.hue_400, dpi(8))
    toggle_systray:connect_signal("button::press", function(_, _, _, button) if (button == 1) then
        tray_container.visible = not systray.visible
        -- awful.spawn('custom-nordvpn-menu')
    end end)
    return {
        toggle_systray,
        tray_container,
        layout = wibox.layout.fixed.horizontal
    }
end

return Systray
