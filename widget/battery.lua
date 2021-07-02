local font_icons = require('layout.font-icons')
local wibox = require('wibox')

local function Battery(s, color)
  return {
    {font_icons.make_faicon(font_icons.battery, color.hue_500), layout = wibox.layout.fixed.horizontal},
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end

return Battery
