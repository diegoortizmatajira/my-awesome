local font_icons = require('widget.font-icons')
local wibox = require('wibox')
local awful = require('awful')

local function Keyboard(s, color)
    return {
        {
            font_icons.make_faicon(font_icons.keyboard, color.hue_500),
            {
                awful.widget.watch([[bash -c "localectl status | grep Layout | cut -d ':' -f2- && echo ''"]], 15),
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

return Keyboard
