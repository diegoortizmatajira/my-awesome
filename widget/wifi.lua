local font_icons = require('layout.font-icons')
local wibox = require('wibox')
local awful = require('awful')

local function Wifi(s, color)
    return {
        {
            font_icons.make_faicon(font_icons.wifi, color.hue_500),
            {
                awful.widget.watch([[awk 'NR==3 {printf "%3.0f %%" ,($3/70)*100}' /proc/net/wireless]], 15),
                fg = color.hue_100,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }
end

return Wifi
