local font_icons = require('layout.font-icons')
local wibox = require('wibox')
local awful = require('awful')

local function Vpn(s, color)
    vpn_widget = wibox.widget {
        {
            font_icons.make_faicon(font_icons.vpn, color.hue_500, 5),
            {
                markup = string.format([[<span color='%s'>%s</span>]], color.hue_100, 'Canada'),
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }
    vpn_widget:connect_signal("button::press", function(_, _, _, button) if (button == 1) then
        awful.spawn('custom-nordvpn-menu')
    end end)
    return vpn_widget
end

return Vpn

