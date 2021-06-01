local font_icons = require('layout.font-icons')
local wibox = require('wibox')

local function Audio(s, color)
    return {
        {font_icons.make_faicon(font_icons.sound_on, color.hue_500), layout = wibox.layout.fixed.horizontal},
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }
end

return Audio
