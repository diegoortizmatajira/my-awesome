local font_icons = require('widget.font-icons')
local wibox = require('wibox')

local function bluetooth(s, color)
  return {
    {font_icons.make_faicon(font_icons.bluetooth, color.hue_500), layout = wibox.layout.fixed.horizontal},
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end

return bluetooth
