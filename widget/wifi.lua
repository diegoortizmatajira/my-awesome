local font_icons = require('layout.font-icons')
local wibox = require('wibox')

local function Wifi(s, color)
    return {
        {font_icons.make_faicon(font_icons.wifi, color.hue_500), layout = wibox.layout.fixed.horizontal},
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }
end

return Wifi
