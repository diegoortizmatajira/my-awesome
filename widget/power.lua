local font_icons = require('layout.font-icons')
local wibox = require('wibox')

local function Power(s, color)
    return {
        {font_icons.make_faicon(font_icons.power, color.hue_500), layout = wibox.layout.fixed.horizontal},
        left = 2,
        right = 2,
        widget = wibox.container.margin
    }
end

return Power

