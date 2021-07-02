local font_icons = require('layout.font-icons')
local wibox = require('wibox')

local function Network(s, color)
  return {
    {font_icons.make_faicon(font_icons.network, color.hue_500), layout = wibox.layout.fixed.horizontal},
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end

return Network
