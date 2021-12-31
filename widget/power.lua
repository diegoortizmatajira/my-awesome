local font_icons = require('widget.font-icons')
local wibox = require('wibox')
local awful = require('awful')
local clickable_container = require('widget.material.clickable-container')

local function Power(_, color)
    local custom_widget = {
        {
            font_icons.make_faicon(font_icons.power, color.hue_500),
            layout = wibox.layout.fixed.horizontal
        },
        left = 2,
        right = 2,
        widget = wibox.container.margin
    }
    local layoutBox = clickable_container(custom_widget)
    layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function()
        awful.spawn('custom-askpoweroptions')
    end)))
    return layoutBox
end

return Power
