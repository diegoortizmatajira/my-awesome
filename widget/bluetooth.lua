local font_icons = require('widget.font-icons')
local wibox = require('wibox')
local clickable_container = require('widget.material.clickable-container')

local function bluetooth(_, color)
    local custom_widget = {
        {
            font_icons.make_faicon(font_icons.bluetooth, color.hue_500),
            layout = wibox.layout.fixed.horizontal
        },
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }
    return clickable_container(custom_widget)
end

return bluetooth
